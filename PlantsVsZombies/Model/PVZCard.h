//
//  PVZCard.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/10.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PVZCard : NSObject

@property (nonatomic, assign) int cardID;

@property (nonatomic, strong) NSString *cardName;
@property (nonatomic, strong) NSString *cardChineseName;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) int cost;
@property (nonatomic, assign) double cd;

@end
