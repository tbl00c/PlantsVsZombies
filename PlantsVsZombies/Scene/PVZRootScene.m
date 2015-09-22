//
//  GameScene.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/29.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZRootScene.h"
#import "PVZButton.h"

#import "PVZUserHelper.h"

#import "PVZUserListViewController.h"
#import "PVZAdventureModeScene.h"
#import "PVZUserRegisterViewController.h"

static PVZRootScene *rootScene = nil;

@interface PVZRootScene () <PVZUserListDelegate, PVZUserRegisterVCDelegate>
{
    SKSpriteNode *backgroundNode;
    int hasSubView;
    
    SKSpriteNode *userNameNode;
    PVZButton *userNameButton;
    PVZButton *changeUserButton;
    SKSpriteNode *warningLabelNode;
    
    SKLabelNode *sceneLabelNode;
    SKLabelNode *toolgateLabelNode;
}

@property (nonatomic, strong) PVZUserListViewController *userListVC;
@property (nonatomic, strong) PVZUserRegisterViewController *registerVC;

@end

@implementation PVZRootScene

+ (PVZRootScene *) sharedRootScene
{
    if (rootScene == nil) {
        rootScene = [PVZRootScene sceneWithSize:CGSizeMake(WIDTH_SCREEN, HEIGHT_SCREEN)];
        rootScene.scaleMode = SKSceneScaleModeAspectFit;
    }
    return rootScene;
}

- (id) initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        [self startInitSubViews];
        hasSubView = 1;
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    //FIXME: 进入前会灰屏

    [self showSubViews];
    
    if (! [[PVZUserHelper sharedUserHelper] autoLogin]) {
        [self showUserRegisterView];
        hasSubView --;
    }
    else {
        PVZUser *user = [PVZUserHelper sharedUserHelper].curUser;
        [userNameButton setTitle:user.username];
        [sceneLabelNode setText:[NSString stringWithFormat:@"%d", user.scene]];
        [toolgateLabelNode setText:[NSString stringWithFormat:@"%d", user.tollgate]];
        hasSubView --;
    }
}

#pragma mark - 按钮点击事件
- (void) vaseButtonDown: (PVZButton *) sender
{
    if (hasSubView != 0) {
        return;
    }
    switch (sender.tag) {
        case 201:       // 选项
            
            break;
        case 202:       // 帮助
            
            break;
        case 203:       // 退出
            exit(0);
            break;
        default:
            break;
    }
}

- (void) modeButtonDown: (PVZButton *) sender
{
    if (hasSubView != 0) {
        return;
    }
    SKAction *wait = [SKAction waitForDuration:0.1];
    [sender setImageNamed:[NSString stringWithFormat:@"select%d1.png", ((int)sender.tag) % 100]];
    [sender runAction:wait completion:^{
        switch (sender.tag) {
            case 101:       // 冒险模式
                [self.view presentScene:[PVZAdventureModeScene sharedAdventureModeScene]];
                break;
            case 102:       // 迷你模式
                
                break;
            case 103:       // 益智模式
                
                break;
            case 104:       // 生存模式
                
                break;
            default:
                break;
        }
        [sender setImageNamed:[NSString stringWithFormat:@"select%d0.png", ((int)sender.tag) % 100]];
    }];
}

- (void) userButtonDown: (PVZButton *) sender
{
    if (hasSubView != 0) {
        return;
    }
    switch (sender.tag) {
        case 301:       // 用户信息
           
            break;
        case 302:       // 更改用户
            hasSubView ++;
            if (_userListVC == nil) {
                _userListVC = [[PVZUserListViewController alloc] init];
                CGRect rect = [UIScreen mainScreen].bounds;
                [_userListVC.view setFrame:CGRectMake(rect.size.width * 0.3, rect.size.height * 0.1, rect.size.width * 0.4, rect.size.height * 0.7)];
                [_userListVC setDelegate:self];
            }
            _userListVC.userListArray = [PVZUserHelper sharedUserHelper].userListArray;
            [self.view addSubview:_userListVC.view];
            break;
        default:
            break;
    }
}

- (void) showUserRegisterView
{
    hasSubView ++;
    if (_registerVC == nil) {
        _registerVC = [[PVZUserRegisterViewController alloc] init];
        [_registerVC setDelegate:self];
        CGRect rect = [UIScreen mainScreen].bounds;
        [_registerVC.view setFrame:CGRectMake(rect.size.width * 0.35, rect.size.height * 0.28, rect.size.width * 0.3, rect.size.height * 0.32)];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view addSubview:_registerVC.view];
    });
}

#pragma mark - PVZUserRegisterVCDelegate
- (void) userRegisterVCCloseButtonDown
{
    if ([PVZUserHelper sharedUserHelper].curUser == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"必须新建一个账号才能开始游戏哦～" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    hasSubView --;
    [_registerVC.view removeFromSuperview];
}

- (BOOL) userRegisterVCTryAddUserByUsername:(NSString *)username
{
    if([[PVZUserHelper sharedUserHelper] addUserByUsername:username andLogin:YES]){
        hasSubView --;
        [_registerVC.view removeFromSuperview];
        [userNameButton setTitle:[PVZUserHelper sharedUserHelper].curUser.username];
        [sceneLabelNode setText:@"1"];
        [toolgateLabelNode setText:@"1"];
        return YES;
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加失败，已存在同名账号。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
}

#pragma mark - PVZUserListDelegate
- (void) userListVCDidSelectUser:(PVZUser *)user
{
    [[PVZUserHelper sharedUserHelper] switchUser:user];
    hasSubView --;
    [_userListVC.view removeFromSuperview];
    [userNameButton setTitle:[PVZUserHelper sharedUserHelper].curUser.username];
    [sceneLabelNode setText:[NSString stringWithFormat:@"%d", user.scene]];
    [toolgateLabelNode setText:[NSString stringWithFormat:@"%d", user.tollgate]];
}

- (void) userListVCAddNewUserButtonDown
{
    hasSubView --;
    [_userListVC.view removeFromSuperview];
    [self showUserRegisterView];
}

- (void) userListVCRemoveUser:(PVZUser *)user
{
    if ([user.username isEqualToString:userNameButton.title]) {
        [userNameButton setTitle:@""];
        [sceneLabelNode setText:@""];
        [toolgateLabelNode setText:@""];
    }
    [[PVZUserHelper sharedUserHelper] removeUser:user];
}

#pragma mark - 加载界面元素
- (void) startInitSubViews
{
    [self removeAllChildren];
    
    backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:@"main_background"];
    backgroundNode.size = self.size;
    backgroundNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:backgroundNode];
    
    // 花瓶选项
    PVZButton *optionsButton = [[PVZButton alloc] initWithTitle:@"选项"];
    optionsButton.tag = 201;
    optionsButton.position = CGPointMake(170, -135);
    optionsButton.zPosition = 2.0;
    [optionsButton addTarget:self action:@selector(vaseButtonDown:)];
    [backgroundNode addChild:optionsButton];
    
    PVZButton *helpButton = [[PVZButton alloc] initWithTitle:@"帮助"];
    helpButton.tag = 202;
    helpButton.position = CGPointMake(228, -152);
    helpButton.zPosition = 2.0;
    [helpButton addTarget:self action:@selector(vaseButtonDown:)];
    [backgroundNode addChild:helpButton];
    
    PVZButton *exitButton = [[PVZButton alloc] initWithTitle:@"退出"];
    exitButton.tag = 203;
    exitButton.position = CGPointMake(285, -148);
    exitButton.zPosition = 2.0;
    [exitButton addTarget:self action:@selector(vaseButtonDown:)];
    [backgroundNode addChild:exitButton];
    
    // 墓碑选项
    PVZButton *adventrueModeButton = [[PVZButton alloc] initWithImageName:@"select10.png"];
    adventrueModeButton.size = CGSizeMake(275, 80);
    adventrueModeButton.position = CGPointMake(145, 105);
    adventrueModeButton.tag = 101;
    adventrueModeButton.zPosition = 1.0;
    [adventrueModeButton addTarget:self action:@selector(modeButtonDown:)];
    [backgroundNode addChild:adventrueModeButton];
    
    PVZButton *miniModeButton = [[PVZButton alloc] initWithImageName:@"select20.png"];
    miniModeButton.size = CGSizeMake(261, 75);
    miniModeButton.position = CGPointMake(137, 46);
    miniModeButton.tag = 102;
    miniModeButton.zPosition = 1.0;
    [miniModeButton addTarget:self action:@selector(modeButtonDown:)];
    [backgroundNode addChild:miniModeButton];
    
    PVZButton *puzzleModeButton = [[PVZButton alloc] initWithImageName:@"select30.png"];
    puzzleModeButton.size = CGSizeMake(242, 78);
    puzzleModeButton.position = CGPointMake(132, -5);
    puzzleModeButton.tag = 103;
    puzzleModeButton.zPosition = 1.0;
    [puzzleModeButton addTarget:self action:@selector(modeButtonDown:)];
    [backgroundNode addChild:puzzleModeButton];
    
    PVZButton *survivalModeButton = [[PVZButton alloc] initWithImageName:@"select40.png"];
    survivalModeButton.size = CGSizeMake(225, 80);
    survivalModeButton.position = CGPointMake(125, -52);
    survivalModeButton.tag = 104;
    survivalModeButton.zPosition = 1.0;
    [survivalModeButton addTarget:self action:@selector(modeButtonDown:)];
    [backgroundNode addChild:survivalModeButton];
    
    // 标识牌信息
    userNameNode = [SKSpriteNode spriteNodeWithImageNamed:@"PlayerScreen"];
    userNameNode.size = CGSizeMake(200, 100);
    userNameNode.speed = 0.5;
    userNameNode.position = CGPointMake(-205, 250);
    userNameNode.zPosition = 1.0;
    [backgroundNode addChild:userNameNode];
    
    userNameButton = [[PVZButton alloc] initWithTitle:@""];
    userNameButton.tag = 301;
    userNameButton.fontSize = 12;
    userNameButton.fontColor = [UIColor orangeColor];
    userNameButton.fontName = @"ChalkboardSE-Light";
    [userNameButton addTarget:self action:@selector(userButtonDown:)];
    userNameButton.position = CGPointMake(-205, 119);
    userNameButton.hidden = YES;
    userNameButton.zPosition = 2.0;
    [backgroundNode addChild:userNameButton];
    
    changeUserButton = [[PVZButton alloc] initWithImageName:@"changePlayer1"];
    changeUserButton.size = CGSizeMake(195, 35);
    changeUserButton.position = CGPointMake(-205, 250);
    changeUserButton.speed = 0.5;
    changeUserButton.tag = 302;
    changeUserButton.zPosition = 1.0;
    [changeUserButton addTarget:self action:@selector(userButtonDown:)];
    [backgroundNode addChild:changeUserButton];
    
    warningLabelNode = [SKSpriteNode spriteNodeWithImageNamed:@"ps.png"];
    warningLabelNode.size = CGSizeMake(200, 40);
    warningLabelNode.position = CGPointMake(-210, 250);
    warningLabelNode.speed = 0.5;
    warningLabelNode.zPosition = 1.0;
    [backgroundNode addChild:warningLabelNode];
    
    // 关卡
    sceneLabelNode = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Light"];
    [sceneLabelNode setFontSize:10.0f];
    [sceneLabelNode setAlpha:0.6];
    [sceneLabelNode setPosition:CGPointMake(138, 123)];
    [sceneLabelNode setZRotation:-M_PI/80];
    [sceneLabelNode setZPosition:2.0];
    [backgroundNode addChild:sceneLabelNode];
    
    toolgateLabelNode = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Light"];
    [toolgateLabelNode setFontSize:10.0f];
    [toolgateLabelNode setAlpha:0.6];
    [toolgateLabelNode setPosition:CGPointMake(163, 122)];
    [toolgateLabelNode setZRotation:-M_PI/80];
    [toolgateLabelNode setZPosition:2.0];
    [backgroundNode addChild:toolgateLabelNode];
}

- (void) showSubViews
{
    SKAction *cp = [SKAction speedTo:5 duration:1];
    SKAction *move = [SKAction moveTo:CGPointMake(-205, 145) duration:0.8];
    [userNameNode runAction:[SKAction group:@[cp, move]] completion:^{
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         userNameButton.hidden = NO;
    });
    
    SKAction *move2 = [SKAction moveTo:CGPointMake(-205, 83) duration:0.9];
    [changeUserButton runAction:[SKAction group:@[cp, move2]]];
    
    SKAction *move3 = [SKAction moveTo:CGPointMake(-210, 55) duration:1.1];
    [warningLabelNode runAction:[SKAction group:@[cp, move3]]];
}

@end
