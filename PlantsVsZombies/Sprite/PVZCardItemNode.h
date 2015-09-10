//
//  PVZCardItem.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/10.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PVZCard.h"

@interface PVZCardItemNode : SKSpriteNode

@property (nonatomic, weak) id skTarget;
@property (nonatomic, assign) SEL skAction;
@property (nonatomic, assign) NSUInteger tag;

@property (nonatomic, strong) PVZCard *cardInfo;

+ (PVZCardItemNode *) createCareItemNodeWithInfo:(PVZCard *) cardInfo;

- (void) addTarget:(id)target action:(SEL)action;

@end
