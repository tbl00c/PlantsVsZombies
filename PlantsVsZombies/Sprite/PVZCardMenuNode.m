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
    //FIXME: 第一次添加会卡顿
    float x = 0;
    float y = HEIGHT_CARDMENU / 2 - HEIGHT_CARDITEM * (_cardArray.count + 0.5);
    [cardItem setPosition:CGPointMake(x, y)];
    [cardItem addTarget:self action:@selector(didSelectCardItem:)];
    
    [_cardArray addObject:cardItem];
    [self addChild:cardItem];
}

/**
 *  删除卡片
 *
 *  @param cardItem 卡片
 */
- (void) removeCardItem:(PVZCardItemNode *)cardItem
{
    int index = (int)[_cardArray indexOfObject:cardItem];
    SKAction *miss = [SKAction fadeAlphaTo:0 duration:0.1];
    SKAction *remove = [SKAction removeFromParent];
    [cardItem runAction:[SKAction sequence:@[miss, remove]]];
    [_cardArray removeObject:cardItem];
    for (int i = index; i < _cardArray.count; i ++) {
        PVZCardItemNode *item = [_cardArray objectAtIndex:i];
        SKAction *move = [SKAction moveByX:0 y:item.size.height duration:0.2];
        [item runAction:move];
    }
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
 *  切换状态
 */
- (void) setStatus:(PVZCardMenuStatus)status
{
    _status = status;
    switch (status) {
        case PVZCardMenuStatusEdit:
            
            break;
        case PVZCardMenuStatusStart:
            for (PVZCardItemNode *node in _cardArray) {
                [node startCooling];
            }
            break;
        case PVZCardMenuStatusPause:
            
            break;
        case PVZCardMenuStatusStop:
            
            break;
        default:
            break;
    }
}

#pragma mark - 卡片点击事件
- (void) didSelectCardItem:(PVZCardItemNode *)cardItem
{
    if (_status == PVZCardMenuStatusStart && _delegate && [_delegate respondsToSelector:@selector(cardMenuDidSelectedCardItem:edit:)]) {
        if ([cardItem isReady] && [_delegate cardMenuDidSelectedCardItem:cardItem.cardInfo edit:NO]) {
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
    else if (_status == PVZCardMenuStatusEdit && _delegate && [_delegate respondsToSelector:@selector(cardMenuDidSelectedCardItem:edit:)]) {
        if([_delegate cardMenuDidSelectedCardItem:cardItem.cardInfo edit:YES]){
            [self removeCardItem:cardItem];
        }
    }
}

@end
