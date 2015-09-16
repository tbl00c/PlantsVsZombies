//
//  PVZSunFactory.h
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/16.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVZSunNode.h"

@interface PVZSunFactory : NSObject

+ (id) createSunAtPosition:(CGPoint)position andType:(PVZSunNodeType)type;
+ (id) createAutoFollowSunAtRect:(CGRect)rect;
+ (void) reusedSunNode:(PVZSunNode *)node;

@end
