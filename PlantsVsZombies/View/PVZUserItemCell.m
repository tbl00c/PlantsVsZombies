//
//  PVZUserItemCell.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/14.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZUserItemCell.h"

@interface PVZUserItemCell ()

@property (nonatomic, strong) UIView *line;

@end

@implementation PVZUserItemCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    if (_line == nil) {
        _line = [[UIView alloc] init];
        [_line setBackgroundColor:[UIColor grayColor]];
        [_line setAlpha:0.6];
        [self addSubview:_line];
    }
    [_line setFrame:CGRectMake(15, self.frameHeight - 0.5, self.frameWidth - 15, 0.5)];
}

- (void) setUserInfo:(PVZUser *)userInfo
{
    [self.textLabel setText:userInfo.username];
    [self.detailTextLabel setFont:[UIFont systemFontOfSize:14]];
    [self.detailTextLabel setText:[NSString stringWithFormat:@"关卡: %d-%d", userInfo.scene, userInfo.tollgate]];
}

@end
