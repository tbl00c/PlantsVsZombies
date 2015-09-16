//
//  PVZSunNode.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/13.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZSunNode.h"

@implementation PVZSunNode

- (SKAction *) dismissActionWithComplete:(void (^)())block;
{
    SKAction *dismiss = [SKAction fadeAlphaTo:0 duration:1.5];
    SKAction *runBlock = [SKAction runBlock:block];
    SKAction *removeBlock = [SKAction runBlock:^{
        [self removeAllActions];
        [self removeFromParent];
    }];
    
    return [SKAction sequence:@[dismiss, runBlock, removeBlock]];
}

- (void) moveToPositionAndDismiss:(CGPoint)position complete:(void (^)())block;
{
    SKAction *moveTo = [SKAction moveTo:position duration: 0.4];
    SKAction *zoom = [SKAction sequence:@[[SKAction scaleTo:0.8 duration:0.3],
                                          [SKAction scaleTo:1.0 duration:0.1],
                                          [SKAction scaleTo:0.3 duration:0.15]]];
    SKAction *action = [SKAction group:@[moveTo, zoom]];
    SKAction *dissmiss = [self dismissActionWithComplete:block];
    [self runAction:[SKAction sequence:@[action, dissmiss]]];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedSunNode:)]) {
        [self removeAllActions];
        [self setAlpha:1.0f];
        [_delegate didSelectedSunNode:self];
    }
}

@end
