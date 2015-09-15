//
//  PVZUserLoginViewController.h
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/14.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PVZUser;

@protocol PVZUserListDelegate <NSObject>

- (void) userListVCDidSelectUser:(PVZUser *)user;
- (void) userListVCAddNewUserButtonDown;
- (void) userListVCRemoveUser:(PVZUser *)user;

@end

@interface PVZUserListViewController : UIViewController

@property (nonatomic, assign) id<PVZUserListDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *userListArray;

@end
