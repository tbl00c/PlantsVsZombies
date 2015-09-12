//
//  PVZSunMenuNode.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/11.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol PVZSunMenuDelegate <NSObject>

- (void) sunMenuNodeDidUpdateSunValue:(float)sunValue;

@end

@interface PVZSunMenuNode : SKSpriteNode

@property (nonatomic, assign) int sunValue;
@property (nonatomic, assign) id<PVZSunMenuDelegate>delegate;

+ (id) createSunMenuNodeWithSunValue:(int)sunValue;;
- (void) addSunValue:(int)value;
- (BOOL) subSunValue:(int)value;
- (BOOL) canSubSunValue:(int)value withAnimation:(BOOL)animation;

@end
