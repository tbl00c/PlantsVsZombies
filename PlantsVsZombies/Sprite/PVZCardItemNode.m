//
//  PVZCardItem.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/10.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZCardItemNode.h"

@interface PVZCardItemNode ()


@end

@implementation PVZCardItemNode

+ (PVZCardItemNode *) createCareItemNodeWithInfo:(PVZCard *)cardInfo
{
    PVZCardItemNode *node = [[PVZCardItemNode alloc] initWithImageNamed:cardInfo.imageName];
    node.cardInfo = cardInfo;
    return node;
}

- (id) initWithImageNamed:(NSString *)name
{
    if (self = [super initWithImageNamed:name]) {
        
    }
    return self;
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
