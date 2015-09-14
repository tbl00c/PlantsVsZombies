//
//  PVZUserLoginViewController.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/14.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZUserListViewController.h"
#import "PVZUserItemCell.h"

@interface PVZUserListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PVZUserListViewController

- (id) init
{
    if (self = [super init]) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[PVZUserItemCell class] forCellReuseIdentifier:@"UserItemCell"];
        [self.view addSubview:_tableView];
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setBackgroundColor:[UIColor blackColor]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_titleLabel setText:@"玩家列表"];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_titleLabel];
    
    _closeButton = [[UIButton alloc] init];
    [_closeButton setBackgroundColor:[UIColor redColor]];
    [_closeButton.layer setMasksToBounds:YES];
    [_closeButton setTitle:@"x" forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonDown) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_closeButton];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGRect rect = self.view.frame;
    [_titleLabel setFrame:CGRectMake(0, 0, rect.size.width, 24)];
    [_closeButton setFrame:CGRectMake(rect.size.width - 18, 4, 16, 16)];
    [_closeButton.layer setCornerRadius:_closeButton.frameWidth * 0.5];
    [self.tableView setFrame:CGRectMake(0, _titleLabel.frameHeight, rect.size.width, rect.size.height - _titleLabel.frameHeight)];
}

- (void) closeButtonDown
{
    [self.view removeFromSuperview];
}

#pragma mark - UITableView
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _userListArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PVZUserItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserItemCell"];
    PVZUser *user = [_userListArray objectAtIndex:indexPath.row];
    [cell setUserInfo: user];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view removeFromSuperview];
}

@end
