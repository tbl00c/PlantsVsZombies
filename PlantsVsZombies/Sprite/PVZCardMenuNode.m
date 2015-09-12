//
//  PVZCardMenu.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/11.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZCardMenuNode.h"

@interface PVZCardMenuNode ()

@property (nonatomic, strong) SKSpriteNode *choosedMarkNode;

@end

@implementation PVZCardMenuNode

+ (PVZCardMenuNode *) createCardMenuNode
{
    PVZCardMenuNode *menu = [PVZCardMenuNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(WIDTH_CARDMENU, HEIGHT_CARDMENU)];
    menu.cardArray = [[NSMutableArray alloc] initWithCapacity:6];
    return menu;
}

/**
 *  添加卡片
 *
 *  @param cardItem  卡片节点
 *  @param animation 是否显示动画
 */
- (void) addCardItem:(PVZCardItemNode *)cardItem withAnimation:(BOOL)animation
{
    float x = 0;
    float y = HEIGHT_CARDMENU / 2 - HEIGHT_CARDITEM * (_cardArray.count + 0.5);
    [cardItem setPosition:CGPointMake(x, y)];
    [cardItem addTarget:self action:@selector(didSelectCardItem:)];
    
    [_cardArray addObject:cardItem];
    [self addChild:cardItem];
}


/**
 *  取消选中状态
 *
 *  @param putPlant 是否成功种植植物
 */
- (void) cancelChooseMenuItemAndPutPlant:(BOOL)putPlant
{
    if (putPlant && _choosedNode) {
        [_choosedNode startCooling];
    }
    [_choosedMarkNode removeFromParent];
    _choosedNode = nil;
}

/**
 *  所有卡片开始冷却
 */
- (void) startAllCardItemCooling
{
    for (PVZCardItemNode *node in _cardArray) {
        [node startCooling];
    }
}

#pragma mark - 卡片点击事件
- (void) didSelectCardItem:(PVZCardItemNode *)cardItem
{
    if (_delegate && [_delegate respondsToSelector:@selector(cardMenuDidSelectedCardItem:)]) {
        if ([cardItem isReady] && [_delegate cardMenuDidSelectedCardItem:cardItem.cardInfo]) {
            if (_choosedMarkNode == nil) {
                _choosedMarkNode = [SKSpriteNode spriteNodeWithImageNamed:@"chooseMenu"];
                [_choosedMarkNode setZPosition:1];
                [_choosedMarkNode setSize:cardItem.size];
            }
            if (_choosedMarkNode.parent == nil) {
                [self addChild:_choosedMarkNode];
            }
            _choosedNode = cardItem;
            [_choosedMarkNode setPosition:cardItem.position];
        }
        else {
            [self cancelChooseMenuItemAndPutPlant:NO];
        }
    }
}

@end
