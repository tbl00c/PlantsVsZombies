//
//  PVZShovelNode.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/22.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZShovelNode.h"

@implementation PVZShovelNode
{
    BOOL isEradicatePlant;
}

+ (id) createShovelNodeAtPoint:(CGPoint)point
{
    PVZShovelNode *node = [PVZShovelNode spriteNodeWithImageNamed:@"Shovel.png"];
    [node setScale:0.72];
    [node setPosition:point];
    [node setBasePoint:point];
    [node setUserInteractionEnabled:YES];
    
    return node;
}

- (void) moveToPoint:(CGPoint)point andEradicatePlants:(void (^)(void))block
{
    [self cancelChoosedShovelNode];
    isEradicatePlant = YES;
    
    self.zRotation = 0.15 * M_PI;
    CGPoint curPoint = CGPointMake(point.x + 30, point.y + 20);
    
    // 铲除植物动画
    SKAction *moveTo = [SKAction moveTo:curPoint duration:0.2];
    SKAction *prepare = [SKAction rotateByAngle:0.25 * M_PI duration:0.5];
    SKAction *step1 = [SKAction group:@[moveTo, prepare]];
    
    curPoint.y -= 30;
    SKAction *down = [SKAction moveTo:curPoint duration:0.5];
    SKAction *rootOut = [SKAction rotateToAngle:0.18 * M_PI * 0.7 duration:0.5];
    SKAction *wait = [SKAction waitForDuration:0.3];
    SKAction *runBlock = [SKAction runBlock:block];
    SKAction *blockAction = [SKAction sequence:@[wait, runBlock]];
    
    SKAction *step2 = [SKAction group:@[down, rootOut, blockAction]];
    
    SKAction *move = [SKAction moveTo:_basePoint duration:0.3];
    
    SKAction *allAction = [SKAction sequence:@[step1, step2, wait, move]];
    
    [self runAction:allAction completion:^{
        self.zRotation = 0;
        isEradicatePlant = NO;
    }];
}

- (void) cancelChoosedShovelNode
{
    if (_isChoosed) {
        _isChoosed = NO;
        [self removeAllActions];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isChoosed || isEradicatePlant) {
        return;
    }
    _isChoosed = YES;
    SKAction *a = [SKAction rotateByAngle:0.1 * M_PI duration:0.01];
    SKAction *b = [SKAction rotateByAngle:-0.1 * M_PI duration:0.02];
    SKAction *c = [SKAction rotateByAngle:0 duration:0.01];
    SKAction *d = [SKAction waitForDuration:1];
    SKAction *all = [SKAction sequence:@[a, b, c, a, b, c, d]];
    [self runAction:[SKAction repeatActionForever:all] completion:^{
        [self cancelChoosedShovelNode];
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectShovelNode)]) {
        [_delegate didSelectShovelNode];
    }
}

@end
