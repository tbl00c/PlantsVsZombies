//
//  PVZUserHelper.h
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/14.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PVZUser.h"

@interface PVZUserHelper : NSObject

@property (nonatomic, strong) PVZUser *curUser;
@property (nonatomic, strong) NSMutableArray *userListArray;

+ (PVZUserHelper *) sharedUserHelper;

- (BOOL) autoLogin;

- (BOOL) addUserByUsername:(NSString *)username andLogin:(BOOL)Login;

- (BOOL) removeUser:(PVZUser *)user;

- (BOOL) switchUser:(PVZUser *)user;

@end
