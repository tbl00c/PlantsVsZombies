//
//  PVZUserRegisterViewController.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/15.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZUserRegisterViewController.h"

@interface PVZUserRegisterViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *usernameTF;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation PVZUserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
   
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setBackgroundColor:[UIColor blackColor]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_titleLabel setText:@"请输入账户名"];
    [self.view addSubview:_titleLabel];
    
    _usernameTF = [[UITextField alloc] init];
    [_usernameTF setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_usernameTF];
    
    _registerButton = [[UIButton alloc] init];
    [_registerButton setBackgroundColor:[UIColor greenColor]];
    [_registerButton setTitle:@"确定" forState:UIControlStateNormal];
    [_registerButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_registerButton.layer setMasksToBounds:YES];
    [_registerButton.layer setCornerRadius:3];
    [_registerButton addTarget:self action:@selector(registerButtonDown) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_registerButton];
    
    _cancelButton = [[UIButton alloc] init];
    [_cancelButton setBackgroundColor:[UIColor grayColor]];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_cancelButton.layer setMasksToBounds:YES];
    [_cancelButton.layer setCornerRadius:3];
    [_cancelButton addTarget:self action:@selector(closeButtonDown) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_cancelButton];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGRect rect = self.view.frame;
    [_titleLabel setFrame:CGRectMake(0, 0, rect.size.width, 24)];
    [_usernameTF setText:@""];
    [_usernameTF setFrame:CGRectMake(10, _titleLabel.frame.size.height + 10, rect.size.width - 20, 35)];
    [_registerButton setFrame:CGRectMake(rect.size.width * 0.05, rect.size.height - 40, rect.size.width * 0.4, 35)];
    [_cancelButton setFrame:CGRectMake(rect.size.width * 0.55, _registerButton.originY, _registerButton.frameWidth, _registerButton.frameHeight)];
    [_usernameTF becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow) name:UIKeyboardWillShowNotification object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) registerButtonDown
{
    if (_usernameTF.text.length == 0) {
        [_usernameTF setPlaceholder:@"请输入账户名"];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(userRegisterVCTryAddUserByUsername:)]) {
        if ([_delegate userRegisterVCTryAddUserByUsername:_usernameTF.text]) {
            [_usernameTF resignFirstResponder];
        }
    }
}

- (void) closeButtonDown
{
    [_usernameTF resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(userRegisterVCCloseButtonDown)]) {
        [_delegate userRegisterVCCloseButtonDown];
    }
}

- (void) keyboardShow
{
    float y = 60;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.originY = y;
    }];
}

@end
