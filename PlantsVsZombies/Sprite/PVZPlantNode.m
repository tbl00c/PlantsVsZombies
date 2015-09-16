//
//  PVZPlantNode.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/14.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZPlantNode.h"

@implementation PVZPlantNode

- (void) setPlantInfo:(PVZPlant *)plantInfo
{
    _plantInfo = plantInfo;
    _hp = _plantInfo.hp;
    NSString *imageName = [plantInfo.texturesDic objectForKey:@"ImageName"];
    int count = getIntValueByObject([plantInfo.texturesDic objectForKey:@"Count"]);
    SKAction *action = [self texturesActionByPhototsCommonName:imageName andCount: count];
    [self runAction:action];
}

@end
