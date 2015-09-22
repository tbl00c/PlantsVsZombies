//
//  PVZPlantNode.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/14.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZPlantNode.h"

@implementation PVZPlantNode

+ (id) createPlant
{
    PVZPlantNode *node = [PVZPlantNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(WIDTH_PLANT, HEIGHT_PLANT)];
    
    return node;
}

- (void) setPlantInfo:(PVZPlant *)plantInfo
{
    _plantInfo = plantInfo;
    _hp = _plantInfo.hp;
    NSString *imageName = [plantInfo.texturesDic objectForKey:@"ImageName"];
    int count = getIntValueByObject([plantInfo.texturesDic objectForKey:@"Count"]);
    SKAction *action = [self texturesActionByPhototsCommonName:imageName andCount: count];
    [self runAction:action];
}

- (void) plantBeenEliminated
{
    SKAction *move = [SKAction moveByX:0 y:12 duration:0.3];
    SKAction *miss = [SKAction fadeAlphaTo:0.8 duration:0.3];
    SKAction *allAction = [SKAction group:@[move, miss]];
    
    [self runAction:allAction completion:^{
        [super removeFromParent];
    }];
}

@end
