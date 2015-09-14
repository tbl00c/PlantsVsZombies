//
//  PVZPlistHelper.h
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/14.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PVZDataHelper : NSObject

+ (NSArray *) getArrayFromPlistByPlistName:(NSString *)plistName;

+ (NSDictionary *) getDictionaryFromPlistByPlistName:(NSString *)plistName;

@end
