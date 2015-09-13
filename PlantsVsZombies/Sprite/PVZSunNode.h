//
//  PVZSunNode.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/13.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSInteger, PVZSunNodeType) {
    PVZSunNodeTypeNormal,
    PVZSunNodeTypeMini,
};

@class PVZSunNode;

@protocol PVZSunNodeDelegate <NSObject>

- (void) didSelectedSunNode:(PVZSunNode *)sunNode;

@end


@interface PVZSunNode : SKSpriteNode

@property (nonatomic, assign) int sunValue;
@property (nonatomic, assign) id<PVZSunNodeDelegate>delegate;

+ (id) createSunAtPosition:(CGPoint)position andType:(PVZSunNodeType)type;
+ (id) createAutoFollowSunAtRect:(CGRect)rect;

- (SKAction *) dismissAction;
- (void) moveToPositionAndDismiss:(CGPoint)position;

@end
