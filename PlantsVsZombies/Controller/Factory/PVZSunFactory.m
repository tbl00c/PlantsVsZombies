//
//  PVZSunFactory.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/16.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZSunFactory.h"

static NSMutableArray *sunReuseArray = nil;

@implementation PVZSunFactory

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
    SKAction *textures = [sunNode texturesActionByPhototsCommonName:@"Sun" andCount:20];
    [sunNode runAction:textures];
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
    SKAction *wait = [SKAction waitForDuration:16.0];
    SKAction *dismiss = [sunNode dismissActionWithComplete:^{
        [PVZSunFactory reusedSunNode:sunNode];
    }];
    [sunNode runAction:[SKAction sequence:@[changeSize, wait, dismiss]]];
    
    return sunNode;
}

+ (id) createAutoFollowSunAtRect:(CGRect)rect
{
    float w = 60.0;
    float x = rect.origin.x + w * 0.6 + arc4random() % ((int)(rect.size.width - rect.origin.x - w));
    float y = rect.origin.y + rect.size.height + w * 1.5;
    PVZSunNode *sunNode = [PVZSunFactory createSunAtPosition:CGPointMake(x, y) andType:PVZSunNodeTypeNormal];
    SKAction *moveFloor = [SKAction moveToY:rect.origin.y + w * 0.7 duration:10.0];
    [sunNode runAction:moveFloor];
    return sunNode;
}

+ (void) reusedSunNode:(PVZSunNode *)node
{
    [sunReuseArray addObject:node];
}


@end
