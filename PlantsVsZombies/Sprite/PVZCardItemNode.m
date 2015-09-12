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
@property (nonatomic, strong) SKSpriteNode *progressNode;

@end

@implementation PVZCardItemNode

+ (PVZCardItemNode *) createCareItemNodeWithInfo:(PVZCard *)cardInfo
{
    PVZCardItemNode *node = [[PVZCardItemNode alloc] initWithImageNamed:cardInfo.imageName];
    [node setSize:CGSizeMake(WIDTH_CARDMENU, HEIGHT_CARDITEM)];
    [node setCardInfo:cardInfo];
    [node setUserInteractionEnabled:YES];
    [node setIsReady:YES];
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
}

/**
 *  开始冷却
 */
- (void) startCooling
{
#ifdef DEBUG_COOLING_CLOSED
    [self setUserInteractionEnabled:YES];
    [self setIsReady:YES];
#else
    [self setUserInteractionEnabled:NO];
    [self setIsReady:NO];
    _progressNode = [SKSpriteNode spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(self.size.width, self.size.height * 0.88)];
    [_progressNode setPosition:CGPointMake(0, - self.size.height * 0.03)];
    [_progressNode setAlpha:0.4];
    [_progressNode setZPosition:1];
    [self addChild:_progressNode];
    SKAction *changeSize = [SKAction resizeToHeight:0 duration:_cardInfo.coolingTime];
    SKAction *changePosition = [SKAction moveTo:CGPointMake(0, self.size.height * 0.42) duration:_cardInfo.coolingTime];
    SKAction *groupAnimation = [SKAction group:@[changeSize, changePosition]];
    [_progressNode runAction:groupAnimation completion:^{
        [self setUserInteractionEnabled:YES];
        [self setIsReady:YES];
    }];
#endif
}

/**
 *  是否冷却完毕
 *
 *  @return 是否冷却完毕
 */
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
