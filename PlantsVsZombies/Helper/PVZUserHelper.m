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
    NSArray *userListArray = [self getUserList];
    if (!userListArray || userListArray.count == 0) {
        return NO;
    }
    _curUser = [userListArray firstObject];
    return YES;
}

- (NSArray *) getUserList
{
    NSMutableArray *userListArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i ++) {
        PVZUser *user = [[PVZUser alloc] init];
        user.username = [NSString stringWithFormat:@"text %d", i];
        user.tollgate = 10;
        [userListArray addObject:user];
    }
    
    return userListArray;
}

- (BOOL) addUserByUsername:(NSString *)username
{
    return YES;
}

@end
