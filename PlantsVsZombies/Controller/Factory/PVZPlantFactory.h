//
//  PVZPlantFactory.h
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/16.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PVZPlant;

@interface PVZPlantFactory : NSObject

+ (id) createPlantNodeByPlantInfo:(PVZPlant *)plantInfo;

@end
