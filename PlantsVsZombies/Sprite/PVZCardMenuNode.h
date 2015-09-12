//
//  PVZCardMenu.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/11.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PVZCardItemNode.h"

@protocol PVZCardMenuDelegate <NSObject>

- (BOOL) cardMenuDidSelectedCardItem:(PVZCard *)cardInfo;

@end

@interface PVZCardMenuNode : SKSpriteNode

@property (nonatomic, strong) NSMutableArray *cardArray;
@property (nonatomic, assign) id<PVZCardMenuDelegate>delegate;
@property (nonatomic, weak) PVZCardItemNode *choosedNode;

+ (PVZCardMenuNode *) createCardMenuNode;

- (void) addCardItem:(PVZCardItemNode *)cardItem withAnimation:(BOOL)animation;
- (void) startAllCardItemCooling;
- (void) cancelChooseMenuItemAndPutPlant:(BOOL)putPlant;

@end
