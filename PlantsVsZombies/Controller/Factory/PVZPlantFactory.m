//
//  PVZPlantFactory.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/16.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZPlantFactory.h"
#import "PVZPlantNode.h"

@implementation PVZPlantFactory

+ (id) createPlantNodeByPlantInfo:(PVZPlant *)plantInfo
{
    NSString *str = [plantInfo.plantName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *className = [NSString stringWithFormat:@"PVZ%@Node", str];
    id node = [NSClassFromString(className) createPlant];
    [node setPlantInfo:plantInfo];
    return node;
}

@end
