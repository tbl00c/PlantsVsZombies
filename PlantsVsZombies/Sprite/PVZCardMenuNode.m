//
//  PVZCardMenu.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/11.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZCardMenuNode.h"

@interface PVZCardMenuNode ()

@property (nonatomic, strong) SKSpriteNode *chooseNode;

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
 */
- (void) resignChooseMenuItem
{
    [_chooseNode removeFromParent];
}

#pragma mark - 卡片点击事件
- (void) didSelectCardItem:(PVZCardItemNode *)cardItem
{
    if (_delegate && [_delegate respondsToSelector:@selector(cardMenuDidSelectedCardItem:)]) {
        if ([cardItem isReady] && [_delegate cardMenuDidSelectedCardItem:cardItem.cardInfo]) {
            if (_chooseNode == nil) {
                _chooseNode = [SKSpriteNode spriteNodeWithImageNamed:@"chooseMenu"];
                [_chooseNode setZPosition:1];
                [_chooseNode setSize:cardItem.size];
            }
            if (_chooseNode.parent == nil) {
                [self addChild:_chooseNode];
            }
            [_chooseNode setPosition:cardItem.position];
        }
        else {
            [self resignChooseMenuItem];
        }
    }
}

@end
