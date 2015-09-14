//
//  PVZUserHelper.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/14.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZUserHelper.h"

static PVZUserHelper *userHelper = nil;

@implementation PVZUserHelper

+ (PVZUserHelper *) sharedUserHelper
{
    if (userHelper == nil) {
        userHelper = [[PVZUserHelper alloc] init];
    }
    return userHelper;
}

- (BOOL) autoLogin
{
    _curUser = [[PVZUser alloc] init];
    _curUser.username = @"text";
    _curUser.tollgate = 7;
    return YES;
}

- (NSArray *) getUserList
{
    NSArray *userList;
    
    return userList;
}

- (BOOL) addUserByUsername:(NSString *)username
{
    return YES;
}

@end
