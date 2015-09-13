//
//  PVZSunNode.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/13.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PVZSunNode : SKSpriteNode

@property (nonatomic, weak) id skTarget;
@property (nonatomic, assign) SEL skAction;

+ (id) createSunAtPosition:(CGPoint)position;

- (void) addTarget:(id)target action:(SEL)action;

@end
