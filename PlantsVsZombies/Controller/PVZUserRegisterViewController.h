//
//  PVZUserRegisterViewController.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/15.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PVZUserRegisterVCDelegate <NSObject>

- (void) userRegisterVCCloseButtonDown;
- (BOOL) userRegisterVCTryAddUserByUsername:(NSString *)username;

@end

@interface PVZUserRegisterViewController : UIViewController

@property (nonatomic, assign) id<PVZUserRegisterVCDelegate>delegate;

@end
