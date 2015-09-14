//
//  PVZPlistHelper.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/14.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZDataHelper.h"

@implementation PVZDataHelper

+ (NSArray *) getArrayFromPlistByPlistName:(NSString *)plistName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSArray *cardsArray = [NSArray arrayWithContentsOfFile: path];
    return cardsArray;
}

+ (NSDictionary *) getDictionaryFromPlistByPlistName:(NSString *)plistName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return dic;
}

@end
