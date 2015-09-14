//
//  AdventureModeScene.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/4.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZAdventureModeScene.h"
#import "PVZGameHelper.h"

#import "PVZBackgroundNode.h"
#import "PVZSunMenuNode.h"
#import "PVZCardMenuNode.h"
#import "PVZSunNode.h"

static PVZAdventureModeScene *adventureModeScene = nil;

@interface PVZAdventureModeScene () <PVZSunMenuDelegate, PVZCardMenuDelegate, PVZBackgroundDelegate, PVZSunNodeDelegate>
{
    NSTimeInterval lastProductSunTime;
}

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
    [self showSubViews];
    
//    [_backgroundNode scrollToShowZombies: nil];
    [_cardMenuNode startAllCardItemCooling];
}

#pragma mark - PVZSunMenuDelegate
- (void) sunMenuNodeDidUpdateSunValue:(float)sunValue
{
    NSLog(@"sun value changed");
}

#pragma mark - PVZCardMenuDelegate
- (BOOL) cardMenuDidSelectedCardItem:(PVZCard *)cardInfo
{
    if ([_sunMenuNode canSubSunValue:cardInfo.cost withAnimation:YES]) {
        _choosedPlant = [SKSpriteNode spriteNodeWithImageNamed:@"SunFlower_2"];
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
        PVZCard *cardInfo = _cardMenuNode.choosedNode.cardInfo;
        
        [_backgroundNode putPlantAtPoint:point plant:_choosedPlant];        // 放置植物
        
        [_sunMenuNode subSunValue:cardInfo.cost];                           // 扣除阳光值
    }
    [_cardMenuNode cancelChooseMenuItemAndPutPlant:canPutPlant];
}

#pragma mark - PVZSunNodeDelegate
- (void) didSelectedSunNode:(PVZSunNode *)sunNode
{
    if (sunNode) {
        [_sunMenuNode addSunValue:sunNode.sunValue];
        [sunNode moveToPositionAndDismiss:CGPointMake(sunNode.size.width * 0.33, self.size.height - sunNode.size.height * 0.37)];
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

    x = WIDTH_SUNMENU / 2 + 3;
    y = HEIGHT_SCREEN - HEIGHT_SUNMENU / 2 - 3;
    _sunMenuNode = [PVZSunMenuNode createSunMenuNodeWithSunValue:50];
    [_sunMenuNode setDelegate:self];
    [_sunMenuNode setPosition:CGPointMake(x, y)];
    [_sunMenuNode setZPosition:1];
    
    x = WIDTH_CARDMENU / 2 + 4;
    y = y - HEIGHT_SUNMENU / 2 - 3 - HEIGHT_CARDMENU / 2;
    _cardMenuNode = [PVZCardMenuNode createCardMenuNode];
    [_cardMenuNode setDelegate:self];
    [_cardMenuNode setPosition:CGPointMake(x, y)];
    [_cardMenuNode setZPosition:1];
    
    [self testCardMenu];
}

- (void) showSubViews
{
    [_backgroundNode setType:PVZBackgroundLawn];
    [self addChild:_backgroundNode];
    [self addChild:_sunMenuNode];
    [self addChild:_cardMenuNode];
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
    if (lastProductSunTime == 0) {
        lastProductSunTime = currentTime - 5;;
    }
    if (currentTime - lastProductSunTime >= 10) {
        lastProductSunTime = currentTime;
        PVZSunNode *sunNode = [PVZSunNode createAutoFollowSunAtRect:CGRectMake(self.size.width * 0.2, 0, self.size.width, self.size.height)];
        [sunNode setDelegate:self];
        [sunNode setZPosition:10];
        [self addChild:sunNode];
    }
}

@end
