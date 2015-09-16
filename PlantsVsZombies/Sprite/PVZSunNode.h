//
//  PVZSunNode.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/13.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSInteger, PVZSunNodeType) {
    PVZSunNodeTypeNormal = 0,
    PVZSunNodeTypeMini,
};

@class PVZSunNode;
@protocol PVZSunNodeDelegate <NSObject>
- (void) didSelectedSunNode:(PVZSunNode *)sunNode;
@end

@interface PVZSunNode : SKSpriteNode

@property (nonatomic, assign) id<PVZSunNodeDelegate>delegate;
@property (nonatomic, assign) int sunValue;

- (SKAction *) dismissActionWithComplete:(void (^)())block;
- (void) moveToPositionAndDismiss:(CGPoint)position complete:(void (^)())block;

@end
