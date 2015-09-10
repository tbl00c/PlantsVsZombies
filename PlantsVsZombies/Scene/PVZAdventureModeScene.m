//
//  AdventureModeScene.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/4.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZAdventureModeScene.h"

#import "PVZBackgroundNode.h"

@interface PVZAdventureModeScene ()

@property (nonatomic, strong) PVZBackgroundNode *backgroundNode;

@end

@implementation PVZAdventureModeScene

- (void) didMoveToView:(SKView *)view
{
    [self initSceneElementByTollGateInfo:_tollgate];
    
    [_backgroundNode scrollToShowZombies: nil];
}

- (void) initSceneElementByTollGateInfo: (PVZTollgate *) tollgate
{
    _backgroundNode = [PVZBackgroundNode createBackgroundNodeByType:PVZBackgroundLawn];
    [_backgroundNode setPosition:CGPointMake(_backgroundNode.size.width * 0.5, CGRectGetMidY(self.frame))];
    [self addChild:_backgroundNode];
   
}

@end
