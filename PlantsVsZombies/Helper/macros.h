//
//  macros.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/30.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#ifndef PlantsVsZombies_macros_h
#define PlantsVsZombies_macros_h

#define APPDELEGETE         ((AppDelegate*)[[UIApplication sharedApplication]delegate])
#define WIDTH_SCREEN        667
#define HEIGHT_SCREEN       375
#define HEIGHT_STATUSBAR	20


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif
