//
//  SKSpriteNode+PVZ.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/13.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKSpriteNode (PVZ)

- (SKAction *) texturesActionByPhototsCommonName:(NSString *)name andCount:(int)count;

@end
