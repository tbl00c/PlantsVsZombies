//
//  PVZCardMenu.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/11.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PVZCardItemNode.h"

typedef NS_ENUM(NSInteger, PVZCardMenuStatus) {
    PVZCardMenuStatusEdit,
    PVZCardMenuStatusStart,
    PVZCardMenuStatusPause,
    PVZCardMenuStatusStop,
};

@protocol PVZCardMenuDelegate <NSObject>

- (BOOL) cardMenuDidSelectedCardItem:(PVZCard *)cardInfo edit:(BOOL)edit;

@end

@interface PVZCardMenuNode : SKSpriteNode

@property (nonatomic, assign) PVZCardMenuStatus status;
@property (nonatomic, strong) NSMutableArray *cardArray;
@property (nonatomic, assign) id<PVZCardMenuDelegate>delegate;
@property (nonatomic, weak) PVZCardItemNode *choosedNode;

+ (PVZCardMenuNode *) createCardMenuNode;

- (void) addCardItem:(PVZCardItemNode *)cardItem withAnimation:(BOOL)animation;
- (void) cancelChooseMenuItemAndPutPlant:(BOOL)putPlant;

@end
