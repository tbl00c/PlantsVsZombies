//
//  AdventureModeScene.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/4.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZAdventureModeScene.h"

#import "PVZBackgroundNode.h"
#import "PVZSunMenuNode.h"
#import "PVZCardMenuNode.h"

static PVZAdventureModeScene *adventureModeScene = nil;

@interface PVZAdventureModeScene () <PVZSunMenuDelegate, PVZCardMenuDelegate, PVZBackgroundDelegate>

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
    PVZCard *card = [[PVZCard alloc] init];
    card.imageName = @"Card_SunFlower";
    card.cost = 50;
    card.coolingTime = 3;
    PVZCardItemNode *node = [PVZCardItemNode createCareItemNodeWithInfo:card];
    [_cardMenuNode addCardItem:node withAnimation:NO];
    PVZCard *card1 = [[PVZCard alloc] init];
    card1.cost = 100;
    card1.coolingTime = 3;
    card1.imageName = @"Card_Peashooter";
    PVZCardItemNode *node1 = [PVZCardItemNode createCareItemNodeWithInfo:card1];
    [_cardMenuNode addCardItem:node1 withAnimation:NO];
    PVZCard *card2 = [[PVZCard alloc] init];
    card2.imageName = @"Card_CherryBomb";
    card2.cost = 120;
    card2.coolingTime = 5;
    PVZCardItemNode *node2 = [PVZCardItemNode createCareItemNodeWithInfo:card2];
    [_cardMenuNode addCardItem:node2 withAnimation:NO];
    PVZCard *card3 = [[PVZCard alloc] init];
    card3.cost = 50;
    card3.coolingTime = 10;
    card3.imageName = @"Card_WallNut";
    PVZCardItemNode *node3 = [PVZCardItemNode createCareItemNodeWithInfo:card3];
    [_cardMenuNode addCardItem:node3 withAnimation:NO];
    PVZCard *card4 = [[PVZCard alloc] init];
    card4.imageName = @"Card_PotatoMine";
    card4.cost = 25;
    card4.coolingTime = 5;
    PVZCardItemNode *node4 = [PVZCardItemNode createCareItemNodeWithInfo:card4];
    [_cardMenuNode addCardItem:node4 withAnimation:NO];
    PVZCard *card5 = [[PVZCard alloc] init];
    card5.imageName = @"Card_SnowPea";
    card5.cost = 175;
    card5.coolingTime = 5;
    PVZCardItemNode *node5 = [PVZCardItemNode createCareItemNodeWithInfo:card5];
    [_cardMenuNode addCardItem:node5 withAnimation:NO];
}

@end
