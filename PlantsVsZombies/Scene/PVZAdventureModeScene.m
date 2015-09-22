//
//  AdventureModeScene.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/4.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZAdventureModeScene.h"
#import "PVZGameHelper.h"
#import "PVZPlantFactory.h"
#import "PVZSunFactory.h"

#import "PVZCardChooseViewController.h"

#import "PVZBackgroundNode.h"
#import "PVZSunMenuNode.h"
#import "PVZCardMenuNode.h"
#import "PVZSunNode.h"

static PVZAdventureModeScene *adventureModeScene = nil;

@interface PVZAdventureModeScene () <PVZCardChooseDelegate, PVZSunMenuDelegate, PVZCardMenuDelegate, PVZBackgroundDelegate, PVZSunNodeDelegate>
{
    NSTimeInterval lastProductSunTime;
    
    BOOL startGame;
}

@property (nonatomic, strong) PVZCardChooseViewController *cardChooseVC;

@property (nonatomic, strong) PVZBackgroundNode *backgroundNode;
@property (nonatomic, strong) PVZSunMenuNode *sunMenuNode;
@property (nonatomic, strong) PVZCardMenuNode *cardMenuNode;

@property (nonatomic, strong) id choosedPlant;

@end

@implementation PVZAdventureModeScene

+ (PVZAdventureModeScene *) sharedAdventureModeScene
{
    if (adventureModeScene == nil) {
        adventureModeScene = [PVZAdventureModeScene sceneWithSize:CGSizeMake(WIDTH_SCREEN, HEIGHT_SCREEN)];
    }
    return adventureModeScene;
}

- (id) initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        [self startInitSubViews];
        
        lastProductSunTime = 0;
    }
    return self;
}

- (void) didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    startGame = NO;
    [self showSubViews];
    
#ifdef DEBUG_DONOT_SHOWZOMBIES
    [self choosedCard];
#else
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_backgroundNode scrollToShowZombies: nil complete:^{  // 展示僵尸
            [self choosedCard];
        }];
    });
#endif
}

#pragma mark - 游戏控制
- (void) choosedCard
{
    [_cardMenuNode setStatus:PVZCardMenuStatusEdit];
#ifdef DEBUG_DEFAULT_CARDS
    [self testCardMenu];
    [self startGame];
#else
    if (_cardChooseVC == nil) {
        _cardChooseVC = [[PVZCardChooseViewController alloc] init];
        [_cardChooseVC.view setFrame:CGRectMake(WIDTH_CARDMENU * 1.5, [UIScreen mainScreen].bounds.size.height * 0.05, [UIScreen mainScreen].bounds.size.width - WIDTH_CARDMENU * 3, [UIScreen mainScreen].bounds.size.height * 0.9)];
        [_cardChooseVC setDelegate:self];
    }
    [_cardChooseVC setCardsArray:[[PVZGameHelper sharedGameHelper] getAllCardsArray] andChooseCount:6];
    [self.view addSubview:_cardChooseVC.view];
#endif
}

- (void) startGame
{
    startGame = YES;
    [_cardMenuNode setStatus:PVZCardMenuStatusStart];        // 卡片开始刷新
}

#pragma mark - PVZCardChooseDelegate
- (void) cardChooseVCDidSelectCard:(PVZCard *)card
{
    NSLog(@"\ncard:%@\nchineseName:%@\niamge:%@\ncost:%d\ncd:%f\n", card.cardName, card.cardChineseName, card.imageName, card.cost, card.cd);
    PVZCardItemNode *node = [PVZCardItemNode createCareItemNodeWithInfo:card];
    [_cardMenuNode addCardItem:node withAnimation:YES];
}

- (void) cardChooseVCCloseButtonDown
{
    [_cardChooseVC.view removeFromSuperview];
    [self startGame];
}

#pragma mark - PVZSunMenuDelegate
- (void) sunMenuNodeDidUpdateSunValue:(float)sunValue
{
}

#pragma mark - PVZCardMenuDelegate
- (BOOL) cardMenuDidSelectedCardItem:(PVZCard *)cardInfo edit:(BOOL)edit
{
    if (edit &&_cardChooseVC) {
        [_cardChooseVC reAddCard:cardInfo];
        return YES;
    }
    else if ([_sunMenuNode canSubSunValue:cardInfo.cost withAnimation:YES]) {
        PVZPlant *plantInfo = [[PVZGameHelper sharedGameHelper] getPlantInfoByCardInfo:cardInfo];
        _choosedPlant = [PVZPlantFactory createPlantNodeByPlantInfo:plantInfo];
        [_choosedPlant setSize:CGSizeMake(46, 52)];
        [_choosedPlant setZPosition:1];
        return YES;
    }
    return NO;
}

#pragma mark - PVZBackgroundDelegate
- (void) backgroundNodeClickedAtPoint:(CGPoint)point canPutPlant:(BOOL)canPutPlant
{
    if (canPutPlant && _cardMenuNode.choosedNode) {
        if (_choosedPlant == nil) {
            PVZLogWarning([self class], @"backgroundNodeClickedAtPoint:canPutPlant:", @"创建植物失败：%@", _cardMenuNode.choosedNode.cardInfo.cardName);
            return;
        }
        [_backgroundNode putPlantAtPoint:point plant:_choosedPlant];            // 放置植物
        [_sunMenuNode subSunValue:_cardMenuNode.choosedNode.cardInfo.cost];     // 扣除阳光值
        [_cardMenuNode cancelChooseMenuItemAndPutPlant:canPutPlant];
        _choosedPlant = nil;
    }
}

#pragma mark - PVZSunNodeDelegate
- (void) didSelectedSunNode:(PVZSunNode *)sunNode
{
    if (sunNode) {
        [_sunMenuNode addSunValue:sunNode.sunValue];
        [sunNode moveToPositionAndDismiss:CGPointMake(sunNode.size.width * 0.33, self.size.height - sunNode.size.height * 0.37) complete:^{
            [PVZSunFactory reusedSunNode:sunNode];
        }];
    }
}

#pragma mark - 加载视图

- (void) startInitSubViews
{
    float x, y;
    _backgroundNode = [PVZBackgroundNode createBackgroundNode];
    [_backgroundNode setPosition:CGPointMake(_backgroundNode.size.width * 0.5, CGRectGetMidY(self.frame))];
    [_backgroundNode setZPosition:0];
    [_backgroundNode setDelegate:self];
    [self addChild:_backgroundNode];

    x = WIDTH_SUNMENU / 2 + 3;
    y = HEIGHT_SCREEN - HEIGHT_SUNMENU / 2 - 3;
    _sunMenuNode = [PVZSunMenuNode createSunMenuNodeWithSunValue:50];
    [_sunMenuNode setDelegate:self];
    [_sunMenuNode setPosition:CGPointMake(x, y)];
    [_sunMenuNode setZPosition:1];
    [self addChild:_sunMenuNode];
    
    x = WIDTH_CARDMENU / 2 + 4;
    y = y - HEIGHT_SUNMENU / 2 - 3 - HEIGHT_CARDMENU / 2;
    _cardMenuNode = [PVZCardMenuNode createCardMenuNode];
    [_cardMenuNode setDelegate:self];
    [_cardMenuNode setPosition:CGPointMake(x, y)];
    [_cardMenuNode setZPosition:1];
    [self addChild:_cardMenuNode];
}

- (void) showSubViews
{
    [_backgroundNode setType:PVZBackgroundLawn];
}

- (void) testCardMenu
{
    NSArray *allCardArray = [[PVZGameHelper sharedGameHelper] getAllCardsArray];
    for (int i = 0; i < 6; i ++) {
        PVZCard *card = [allCardArray objectAtIndex:i];
        PVZCardItemNode *node = [PVZCardItemNode createCareItemNodeWithInfo:card];
        [_cardMenuNode addCardItem:node withAnimation:NO];
    }
}

- (void) update:(NSTimeInterval)currentTime
{
    if (!startGame) {
        return;
    }
    if (lastProductSunTime == 0) {
        lastProductSunTime = currentTime - 15;
    }
    if (currentTime - lastProductSunTime >= 20) {
        lastProductSunTime = currentTime;
        PVZSunNode *sunNode = [PVZSunFactory createAutoFollowSunAtRect:CGRectMake(self.size.width * 0.2, 0, self.size.width, self.size.height)];
        [sunNode setDelegate:self];
        [sunNode setZPosition:10];
        [self addChild:sunNode];
    }
}

@end
