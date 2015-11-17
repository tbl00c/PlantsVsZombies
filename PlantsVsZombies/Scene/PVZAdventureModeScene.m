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
#import "PVZShovelNode.h"
#import "PVZPlantNode.h"

static PVZAdventureModeScene *adventureModeScene = nil;

@interface PVZAdventureModeScene () <PVZCardChooseDelegate, PVZSunMenuDelegate, PVZShovelNodeDelegate, PVZCardMenuDelegate, PVZBackgroundDelegate, PVZSunNodeDelegate>
{
    NSTimeInterval lastProductSunTime;
    
    BOOL startGame;
}

@property (nonatomic, strong) PVZCardChooseViewController *cardChooseVC;

@property (nonatomic, strong) PVZBackgroundNode *backgroundNode;
@property (nonatomic, strong) PVZSunMenuNode *sunMenuNode;
@property (nonatomic, strong) PVZCardMenuNode *cardMenuNode;
@property (nonatomic, strong) PVZShovelNode *shavelNode;

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
/**
 *  选取本局要使用的卡片
 */
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
/**
 *  选中了某卡片
 *
 *  @param card 选中的卡片信息
 */
- (void) cardChooseVCDidSelectCard:(PVZCard *)card
{
    NSLog(@"\ncard:%@\nchineseName:%@\niamge:%@\ncost:%d\ncd:%f\n", card.cardName, card.cardChineseName, card.imageName, card.cost, card.cd);
    PVZCardItemNode *node = [PVZCardItemNode createCareItemNodeWithInfo:card];
    [_cardMenuNode addCardItem:node withAnimation:YES];
}

/**
 *  选择卡片完成
 */
- (void) cardChooseVCCloseButtonDown
{
    [_cardChooseVC.view removeFromSuperview];
    [self startGame];
}

#pragma mark - PVZShovelNodeDelegate
/**
 *  铲子点击回调
 */
- (void) didSelectShovelNode
{
    [_cardMenuNode cancelChooseMenuItemAndStartCooling:NO];
    _choosedPlant = nil;
}

#pragma mark - PVZSunMenuDelegate
/**
 *  阳光值变化回调
 *
 *  @param sunValue 当前阳光值
 */
- (void) sunMenuNodeDidUpdateSunValue:(float)sunValue
{
}

#pragma mark - PVZCardMenuDelegate
/**
 *  选中卡片后回调
 *
 *  @param cardInfo 选中卡片的信息
 *  @param edit     是否在编辑状态
 *
 *  @return 操作是否成功
 */
- (BOOL) cardMenuDidSelectedCardItem:(PVZCard *)cardInfo edit:(BOOL)edit
{
    [_shavelNode cancelChoosedShovelNode];
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
/**
 *  主场景的点击事件
 *
 *  @param point       点击点
 *  @param canPutPlant 能否放置植物
 */
- (void) backgroundNodeClickedAtPoint:(CGPoint)point canPutPlantType:(PVZCanPutPlantType)type plant:(id)plant
{
    if (type == PVZCanPutPlantAll && _cardMenuNode.choosedNode) {
        if (_choosedPlant == nil) {
            PVZLogWarning([self class], @"backgroundNodeClickedAtPoint:canPutPlant:", @"创建植物失败：%@", _cardMenuNode.choosedNode.cardInfo.cardName);
            [UIAlertView showAlertViewWithTitle:@"提示" message:[NSString stringWithFormat:@"创建植物失败:%@",_cardMenuNode.choosedNode.cardInfo.cardName]];
            return;
        }
        [_backgroundNode putPlantAtPoint:point plant:_choosedPlant];            // 放置植物
        [_sunMenuNode subSunValue:_cardMenuNode.choosedNode.cardInfo.cost];     // 扣除阳光值
        [_cardMenuNode cancelChooseMenuItemAndStartCooling:YES];
        _choosedPlant = nil;
    }
    else if (plant != nil && _shavelNode.isChoosed) {
        CGPoint position = [_backgroundNode getPlantItemPostionByMapPoint:point];
        position = [self convertPoint:position fromNode:_backgroundNode];
        [_shavelNode moveToPoint:position andEradicatePlants:^{
            [plant plantBeenEliminated];
            [_backgroundNode removePlantAtPoint:point];
        }];
    }
}

#pragma mark - PVZSunNodeDelegate
/**
 *  阳光点击时间
 *
 *  @param sunNode 阳光Node
 */
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
    
    x = WIDTH_SCREEN - 50;
    y = HEIGHT_SCREEN - HEIGHT_SUNMENU / 2 - 3;
    _shavelNode = [PVZShovelNode createShovelNodeAtPoint:CGPointMake(x, y)];
    [_shavelNode setDelegate:self];
    [_shavelNode setZPosition:1];
    [self addChild:_shavelNode];
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
