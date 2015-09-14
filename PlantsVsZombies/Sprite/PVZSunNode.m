//
//  PVZSunNode.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/13.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZSunNode.h"

static NSMutableArray *sunReuseArray = nil;

@implementation PVZSunNode

+ (id) createSunAtPosition:(CGPoint)position andType:(PVZSunNodeType)type
{
    if (sunReuseArray == nil) {
        sunReuseArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    PVZSunNode *sunNode;
    if (sunReuseArray.count > 0) {
        sunNode = [sunReuseArray lastObject];
        [sunNode setAlpha:0.95];
        [sunNode setScale:1.0];
        [sunReuseArray removeLastObject];
    }
    else {
        sunNode = [PVZSunNode spriteNodeWithImageNamed:@"Sun_0"];
        [sunNode setAlpha:0.95];
        [sunNode setUserInteractionEnabled:YES];
    }
    [sunNode addTexturesByPhototsCommonName:@"Sun_" andCount: 20];
    [sunNode setPosition:position];
    [sunNode setSize:CGSizeMake(0, 0)];
    SKAction *changeSize;
    switch (type) {
        case PVZSunNodeTypeNormal:
            changeSize = [SKAction resizeByWidth:55 height:55 duration:0.5];
            sunNode.sunValue = 25;
            break;
        case PVZSunNodeTypeMini:
            changeSize = [SKAction resizeByWidth:35 height:35 duration:0.5];
            sunNode.sunValue = 15;
            break;
        default:
            break;
    }
    SKAction *wait = [SKAction waitForDuration:12.0];
    SKAction *dismiss = [sunNode dismissAction];
    [sunNode runAction:[SKAction sequence:@[changeSize, wait, dismiss]]];
    
    return sunNode;
}

+ (id) createAutoFollowSunAtRect:(CGRect)rect
{
    float w = 60.0;
    float x = rect.origin.x + w * 0.6 + arc4random() % ((int)(rect.size.width - rect.origin.x - w));
    float y = rect.origin.y + rect.size.height + w * 1.5;
    PVZSunNode *sunNode = [PVZSunNode createSunAtPosition:CGPointMake(x, y) andType:PVZSunNodeTypeNormal];
    SKAction *moveFloor = [SKAction moveToY:rect.origin.y + w * 0.7 duration:6.0];
    [sunNode runAction:moveFloor];
    return sunNode;
}

- (SKAction *) dismissAction
{
    SKAction *dismiss = [SKAction fadeAlphaTo:0 duration:1.5];
    SKAction *runBlock = [SKAction runBlock:^{
        [self removeAllActions];
        [self removeFromParent];
        [sunReuseArray addObject:self];
    }];
    return [SKAction sequence:@[dismiss, runBlock]];
}

- (void) moveToPositionAndDismiss:(CGPoint)position
{
    SKAction *moveTo = [SKAction moveTo:position duration: 0.4];
    SKAction *zoom = [SKAction sequence:@[[SKAction scaleTo:0.8 duration:0.3],
                                          [SKAction scaleTo:1.0 duration:0.1],
                                          [SKAction scaleTo:0.3 duration:0.15]]];
    SKAction *action = [SKAction group:@[moveTo, zoom]];
    SKAction *dissmiss = [self dismissAction];
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
