//
//  PVZCardChooseViewController.h
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/15.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PVZCard;

@protocol PVZCardChooseDelegate <NSObject>

- (void) cardChooseVCDidSelectCard:(PVZCard *)card;
- (void) cardChooseVCCloseButtonDown;

@end

@interface PVZCardChooseViewController : UIViewController

@property (nonatomic, assign) id<PVZCardChooseDelegate>delegate;

- (void) setCardsArray:(NSArray *)array andChooseCount:(int)count;
- (void) reAddCard:(PVZCard *)card;

@end
