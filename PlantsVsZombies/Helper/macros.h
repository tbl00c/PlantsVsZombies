//
//  macros.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/30.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#ifndef PlantsVsZombies_macros_h
#define PlantsVsZombies_macros_h

#define WIDTH_SCREEN        667
#define HEIGHT_SCREEN       375

#define WIDTH_SUNMENU       123
#define HEIGHT_SUNMENU      37

#define WIDTH_CARDMENU      76
#define HEIGHT_CARDMENU     300
#define HEIGHT_CARDITEM     43



#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif
