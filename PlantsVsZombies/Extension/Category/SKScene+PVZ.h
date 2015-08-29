//
//  SKScene+PVZ.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/29.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKScene (PVZ)

+ (instancetype)unarchiveFromFile:(NSString *)file;

@end
