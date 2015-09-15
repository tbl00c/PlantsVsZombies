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
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    
    [self.tableView reloadData];
}

- (void) closeButtonDown
{
    if (_userListArray.count == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"必须选中一个账号～" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(userListVCDidSelectUser:)]) {
        [_delegate userListVCDidSelectUser:[_userListArray objectAtIndex:0]];
    }
}

#pragma mark - UITableView
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? _userListArray.count : 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PVZUserItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserItemCell"];
        if (cell == nil) {
            cell = [[PVZUserItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UserItemCell"];
        }
        PVZUser *user = [_userListArray objectAtIndex:indexPath.row];
        [cell setUserInfo: user];
        if (indexPath.row == 0) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddUserCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddUserCell"];
        }
        [cell.textLabel setText:@"添加新账号"];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(userListVCDidSelectUser:)]) {
            PVZUser *user = [_userListArray objectAtIndex:indexPath.row];
            [_delegate userListVCDidSelectUser:user];
        }
    }
    else if (indexPath.section == 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(userListVCAddNewUserButtonDown)]) {
            [_delegate userListVCAddNewUserButtonDown];
        }
    }
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return YES;
    }
    return NO;
}

- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除账户";
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PVZUser *user = [_userListArray objectAtIndex:indexPath.row];
        [_userListArray removeObject: user];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        if (_delegate && [_delegate respondsToSelector:@selector(userListVCRemoveUser:)]) {
            [_delegate userListVCRemoveUser:user];
        }
    }
}

@end
