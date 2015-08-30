//
//  common.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/30.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "common.h"

void PVZLogError(NSString *className, NSString *funcName, NSError *error)
{
    NSLog(@"ERROR\nClass: %@\nFunc: %@\nInfo: %@", className, funcName, error);
}

void PVZLogWarning(id className, id funcName, NSString *format,...)
{
    va_list args;
    va_start(args, format);
    NSString * str = [[NSString alloc] initWithFormat:format arguments:args];
    NSLog(@"WARNING\nClass: %@\nFunc: %@\nInfo: %@", className, funcName, str);
    va_end(args);
}