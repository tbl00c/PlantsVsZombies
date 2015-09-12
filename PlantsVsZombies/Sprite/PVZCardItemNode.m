//
//  PVZCardItem.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/10.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZCardItemNode.h"

@interface PVZCardItemNode ()

@property (nonatomic, strong) SKLabelNode *costLabel;

@end

@implementation PVZCardItemNode

+ (PVZCardItemNode *) createCareItemNodeWithInfo:(PVZCard *)cardInfo
{
    PVZCardItemNode *node = [[PVZCardItemNode alloc] initWithImageNamed:cardInfo.imageName];
    [node setUserInteractionEnabled:YES];
    [node setSize:CGSizeMake(WIDTH_CARDMENU, HEIGHT_CARDITEM)];
    [node setCardInfo:cardInfo];
    return node;
}

/**
 *  设置卡片信息
 *
 *  @param cardInfo 卡片信息
 */
- (void) setCardInfo:(PVZCard *)cardInfo
{
    _cardInfo = cardInfo;
    if (_costLabel == nil) {
        _costLabel = [SKLabelNode labelNodeWithFontNamed:@""];
        [_costLabel setFontSize:11.0f];
        [_costLabel setFontColor:[UIColor blackColor]];
        [_costLabel setPosition:CGPointMake(WIDTH_CARDMENU * (cardInfo.cost >= 100 ? 0.283 : 0.32), - HEIGHT_CARDITEM * 0.43)];
        [self addChild:_costLabel];
    }
    [_costLabel setText:[NSString stringWithFormat:@"%3d", cardInfo.cost]];
    [self setIsReady:YES];
}

- (BOOL) isReady
{
    if (! _isReady) {
        
    }
    return _isReady;
}

#pragma mark - 点击事件
- (void) addTarget:(id)target action:(SEL)action
{
    _skTarget = target;
    _skAction = action;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_skAction && _skTarget) {
        SuppressPerformSelectorLeakWarning([_skTarget performSelector:_skAction withObject:self]);
    }
}

@end
