//
//  PVZLawn.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/10.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSInteger, PVZBackgroundType) {
    PVZBackgroundLawnEmpty,     // 绿地
    PVZBackgroundLawnOne,
    PVZBackgroundLawnThree,
    PVZBackgroundLawn,
    PVZBackgroundLawnDark,      // 绿地黑天
    PVZBackgroundRoof,          // 屋顶
    PVZBackgroundRoofDark,      // 屋顶黑天
    PVZBackgroundPool,          // 泳池
    PVZBackgroundPoolDark,
};

@interface PVZBackgroundNode : SKSpriteNode

@property (nonatomic, assign) PVZBackgroundType type;

+ (PVZBackgroundNode *) createBackgroundNodeByType: (PVZBackgroundType) type;
- (void) scrollToShowZombies:(NSArray *)zombies;

@end
