//
//  PVZPlant.h
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/14.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSInteger, PVZPlantType) {
    PVZPlantTypeEconomics = 0,      // 经济类
    PVZPlantTypeAttack = 1,         // 攻击类
    PVZPlantTypeDefense = 2,        // 防御类
    PVZPlantTypeConsume = 3,        // 消耗类
    PVZPlantTypeTerrace = 4,        // 平台类
    PVZPlantTypeAssist = 5,         // 辅助类
};

@interface PVZPlant : NSObject

@property (nonatomic, assign) int plantID;

@property (nonatomic, assign) PVZPlantType plantType;

@property (nonatomic, strong) NSString *plantName;

@property (nonatomic, strong) NSString *plantChineseName;

@property (nonatomic, assign) float hp;

@property (nonatomic, assign) float cd;

@property (nonatomic, strong) NSDictionary *texturesDic;

@property (nonatomic, strong) NSDictionary *skillTexturesDic;

@property (nonatomic, strong) NSMutableArray *hpTexturesArray;

@property (nonatomic, strong) NSMutableArray *timeTexturesArray;


@end
