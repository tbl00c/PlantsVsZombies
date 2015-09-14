//
//  common.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/30.
//  Copyright (c) 2015年 lbk. All rights reserved.
//
#import <Foundation/Foundation.h>

void PVZLogError(id className, id funcName, NSError *error);
void PVZLogWarning(id className, id funcName, NSString *format,...);
float getFloatValueByObject(id obj);
float getIntValueByObject(id obj);
float getDoubleValueByObject(id obj);

