//
//  PVZConfigration.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/29.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZConfigration.h"

static PVZConfigration *configration = nil;

@implementation PVZConfigration

+ (PVZConfigration *) sharedConfigration
{
    if (configration == nil) {
        configration = [[PVZConfigration alloc] init];
    }
    return configration;
}

@end
