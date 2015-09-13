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

+ (id) createSunAtPosition:(CGPoint)position
{
    if (sunReuseArray == nil) {
        sunReuseArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    PVZSunNode *sunNode;
    if (sunReuseArray.count > 0) {
        sunNode = [sunReuseArray lastObject];
        [sunReuseArray removeLastObject];
    }
    else {
        sunNode = [PVZSunNode spriteNodeWithImageNamed:@"Sun_0"];
        [sunNode addTexturesByPhototsCommonName:@"Sun_" andCount: 20];
        [sunNode setZPosition:1.0];
        [sunNode setAlpha:0.95];
        [sunNode setUserInteractionEnabled:YES];
    }
    [sunNode setPosition:position];
    
    return sunNode;
}

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
