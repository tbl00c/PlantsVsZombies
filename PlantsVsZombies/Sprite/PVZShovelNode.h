//
//  PVZShovelNode.h
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/22.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol PVZShovelNodeDelegate <NSObject>

- (void) didSelectShovelNode;

@end

@interface PVZShovelNode : SKSpriteNode

@property (nonatomic, assign) id<PVZShovelNodeDelegate>delegate;
@property (nonatomic, assign) CGPoint basePoint;
@property (nonatomic, assign) BOOL isChoosed;

+ (id) createShovelNodeAtPoint:(CGPoint)point;
- (void) moveToPoint: (CGPoint) point andEradicatePlants:(void (^)(void))block;

- (void) cancelChoosedShovelNode;

@end
