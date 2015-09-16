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
    if (!self.userListArray || self.userListArray.count == 0) {
        return NO;
    }
    _curUser = [_userListArray firstObject];
    return YES;
}

- (NSMutableArray *) userListArray
{
    if(_userListArray == nil) {
        _userListArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i ++) {
            PVZUser *user = [[PVZUser alloc] init];
            user.username = [NSString stringWithFormat:@"text %d", i];
            user.scene = 1;
            user.tollgate = 7;
            [_userListArray addObject:user];
        }
    }
    
    return _userListArray;
}

- (BOOL) addUserByUsername:(NSString *)username andLogin:(BOOL)login
{
    for (PVZUser *item in _userListArray) {
        if ([item.username isEqualToString:username]) {
            return NO;
        }
    }
    PVZUser *user = [[PVZUser alloc] init];
    user.username = username;
    user.scene = 1;
    user.tollgate = 1;
    if (login) {
        _curUser = user;
        [self.userListArray insertObject:user atIndex:0];
    }
    else {
        [self.userListArray addObject:user];
    }
    return YES;
}

- (BOOL) removeUser:(PVZUser *)user
{
    [self.userListArray removeObject:user];
    return YES;
}

- (BOOL) switchUser:(PVZUser *)user
{
    _curUser = user;
    [self.userListArray removeObject:user];
    [self.userListArray insertObject:user atIndex:0];
    return YES;
}

@end
