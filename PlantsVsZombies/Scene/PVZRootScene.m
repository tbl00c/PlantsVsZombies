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

static PVZRootScene *rootScene = nil;

@interface PVZRootScene ()
{
    SKSpriteNode *backgroundNode;
    
    
    SKSpriteNode *userNameNode;
    PVZButton *userNameButton;
    PVZButton *changeUserButton;
    SKSpriteNode *warningLabelNode;
}

@property (nonatomic, strong) PVZUserListViewController *userListVC;

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
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];

    [self showSubViews];
    
    if (! [[PVZUserHelper sharedUserHelper] autoLogin]) {
        //TODO: 无用户数据
    }
    else {
        [userNameButton setTitle:[PVZUserHelper sharedUserHelper].curUser.username];
    }
}

#pragma mark - 按钮点击事件
- (void) vaseButtonDown: (PVZButton *) sender
{
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
}

- (void) userButtonDown: (PVZButton *) sender
{
    switch (sender.tag) {
        case 301:       // 用户信息
            
            break;
        case 302:       // 更改用户
            if (_userListVC == nil) {
                _userListVC = [[PVZUserListViewController alloc] init];
                [_userListVC.view setFrame:CGRectMake(WIDTH_SCREEN * 0.3, HEIGHT_SCREEN * 0.1, WIDTH_SCREEN * 0.4, HEIGHT_SCREEN * 0.7)];
            }
            _userListVC.userListArray = [[PVZUserHelper sharedUserHelper] getUserList];
            [self.view addSubview:_userListVC.view];
            break;
        default:
            break;
    }
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
    [optionsButton addTarget:self action:@selector(vaseButtonDown:)];
    [backgroundNode addChild:optionsButton];
    
    PVZButton *helpButton = [[PVZButton alloc] initWithTitle:@"帮助"];
    helpButton.tag = 202;
    helpButton.position = CGPointMake(228, -152);
    [helpButton addTarget:self action:@selector(vaseButtonDown:)];
    [backgroundNode addChild:helpButton];
    
    PVZButton *exitButton = [[PVZButton alloc] initWithTitle:@"退出"];
    exitButton.tag = 203;
    exitButton.position = CGPointMake(285, -148);
    [exitButton addTarget:self action:@selector(vaseButtonDown:)];
    [backgroundNode addChild:exitButton];
    
    // 墓碑选项
    PVZButton *adventrueModeButton = [[PVZButton alloc] initWithImageName:@"select10.png"];
    adventrueModeButton.size = CGSizeMake(275, 80);
    adventrueModeButton.position = CGPointMake(145, 105);
    adventrueModeButton.tag = 101;
    [adventrueModeButton addTarget:self action:@selector(modeButtonDown:)];
    [backgroundNode addChild:adventrueModeButton];
    
    PVZButton *miniModeButton = [[PVZButton alloc] initWithImageName:@"select20.png"];
    miniModeButton.size = CGSizeMake(261, 75);
    miniModeButton.position = CGPointMake(137, 46);
    miniModeButton.tag = 102;
    [miniModeButton addTarget:self action:@selector(modeButtonDown:)];
    [backgroundNode addChild:miniModeButton];
    
    PVZButton *puzzleModeButton = [[PVZButton alloc] initWithImageName:@"select30.png"];
    puzzleModeButton.size = CGSizeMake(242, 78);
    puzzleModeButton.position = CGPointMake(132, -5);
    puzzleModeButton.tag = 103;
    [puzzleModeButton addTarget:self action:@selector(modeButtonDown:)];
    [backgroundNode addChild:puzzleModeButton];
    
    PVZButton *survivalModeButton = [[PVZButton alloc] initWithImageName:@"select40.png"];
    survivalModeButton.size = CGSizeMake(225, 80);
    survivalModeButton.position = CGPointMake(125, -52);
    survivalModeButton.tag = 104;
    [survivalModeButton addTarget:self action:@selector(modeButtonDown:)];
    [backgroundNode addChild:survivalModeButton];
    
    // 标识牌信息
    userNameNode = [SKSpriteNode spriteNodeWithImageNamed:@"PlayerScreen"];
    userNameNode.size = CGSizeMake(200, 100);
    userNameNode.speed = 0.5;
    userNameNode.position = CGPointMake(-205, 250);
    [backgroundNode addChild:userNameNode];
    
    userNameButton = [[PVZButton alloc] initWithTitle:@""];
    userNameButton.tag = 301;
    userNameButton.fontSize = 12;
    userNameButton.fontColor = [UIColor orangeColor];
    userNameButton.fontName = @"ChalkboardSE-Light";
    [userNameButton addTarget:self action:@selector(userButtonDown:)];
    userNameButton.position = CGPointMake(-205, 119);
    userNameButton.hidden = YES;
    [backgroundNode addChild:userNameButton];
    
    changeUserButton = [[PVZButton alloc] initWithImageName:@"changePlayer1"];
    changeUserButton.size = CGSizeMake(195, 35);
    changeUserButton.position = CGPointMake(-205, 250);
    changeUserButton.speed = 0.5;
    changeUserButton.tag = 302;
    [changeUserButton addTarget:self action:@selector(userButtonDown:)];
    [backgroundNode addChild:changeUserButton];
    
    warningLabelNode = [SKSpriteNode spriteNodeWithImageNamed:@"ps.png"];
    warningLabelNode.size = CGSizeMake(200, 40);
    warningLabelNode.position = CGPointMake(-210, 250);
    warningLabelNode.speed = 0.5;
    [backgroundNode addChild:warningLabelNode];
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
