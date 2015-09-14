//
//  PVZUserItemCell.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/14.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZUserItemCell.h"

@implementation PVZUserItemCell

- (void) setUserInfo:(PVZUser *)userInfo
{
    [self.textLabel setText:userInfo.username];
}

@end
