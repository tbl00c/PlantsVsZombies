//
//  SKSpriteNode+PVZ.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/13.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "SKSpriteNode+PVZ.h"

@implementation SKSpriteNode (PVZ)

- (SKAction *) texturesActionByPhototsCommonName:(NSString *)name andCount:(int)count
{
    NSMutableArray *texturesArray = [[NSMutableArray alloc] initWithCapacity:count];
    for (int i = 0; i < count; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"%@%d.png", name, i];
        SKTexture *texture = [SKTexture textureWithImageNamed:imageName];
        [texturesArray addObject:texture];
    }
    [self removeAllActions];
    SKAction *action = [SKAction animateWithTextures:texturesArray timePerFrame:0.1];
    return action;
}

@end
