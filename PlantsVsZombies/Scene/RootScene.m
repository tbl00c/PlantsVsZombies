//
//  GameScene.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/29.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "RootScene.h"
#import "PVZButton.h"

@implementation RootScene

-(void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    [self showMainMenu];
}

- (void) showMainMenu
{
    [self removeAllChildren];
    
    SKSpriteNode *backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:@"main_background"];
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
    SKSpriteNode *userNameNode = [SKSpriteNode spriteNodeWithImageNamed:@"PlayerScreen"];
    userNameNode.size = CGSizeMake(200, 100);
    userNameNode.speed = 0.5;
    userNameNode.position = CGPointMake(-205, 250);
    [backgroundNode addChild:userNameNode];
    SKAction *cp = [SKAction speedTo:5 duration:1];
    SKAction *move = [SKAction moveTo:CGPointMake(-205, 145) duration:0.8];
    [userNameNode runAction:[SKAction group:@[cp, move]]];
    
    PVZButton *changeUserButton = [[PVZButton alloc] initWithImageName:@"changePlayer1"];
    changeUserButton.size = CGSizeMake(195, 35);
    changeUserButton.position = CGPointMake(-205, 250);
    changeUserButton.speed = 0.5;
    changeUserButton.tag = 302;
    [changeUserButton addTarget:self action:@selector(userButtonDown:)];
    [backgroundNode addChild:changeUserButton];
    SKAction *move2 = [SKAction moveTo:CGPointMake(-205, 83) duration:0.9];
    [changeUserButton runAction:[SKAction group:@[cp, move2]]];
    
    SKSpriteNode *warningLabelNode = [SKSpriteNode spriteNodeWithImageNamed:@"ps.png"];
    warningLabelNode.size = CGSizeMake(200, 40);
    warningLabelNode.position = CGPointMake(-210, 250);
    warningLabelNode.speed = 0.5;
    [backgroundNode addChild:warningLabelNode];
    SKAction *move3 = [SKAction moveTo:CGPointMake(-210, 55) duration:1.1];
    [warningLabelNode runAction:[SKAction group:@[cp, move3]]];
}

#pragma mark - Button Action
- (void) vaseButtonDown: (PVZButton *) sender
{
    NSLog(@"vase button down, %lu", (unsigned long)sender.tag);
}

- (void) modeButtonDown: (PVZButton *) sender
{
    NSLog(@"mode button down, %lu", (unsigned long)sender.tag);
}

- (void) userButtonDown: (PVZButton *) sender
{
    NSLog(@"user button down, %lu", (unsigned long)sender.tag);
}

@end
