//
//  UIAlertView+Blocks.h
//  WhichBanker
//
//  Created by 李伯坤 on 15/9/29.
//  Copyright (c) 2015年 lettai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WBAlertViewBlock)();
typedef void (^WBAlertViewTextBlock)(NSString *text);

@interface UIAlertView (Blocks)

- (id) initWithTitle:(NSString *)title
             message:(NSString *)message
   cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitle:(NSString *)otherButtonTitles
   cancelButtonBlock:(WBAlertViewBlock)cancelButtonBlock
    otherButtonBlock:(WBAlertViewBlock)otherButtonBlock;


- (id) initWithTitle:(NSString *)title
             message:(NSString*)message
         placeholder:(NSString *)placeholder  
   cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitle:(NSString *)otherButtonTitle
   cancelButtonBlock:(WBAlertViewBlock)cancelButtonBlock
    otherButtonBlock:(WBAlertViewTextBlock)otherButtonBlock;

+ (void) showAlertViewWithTitle:(NSString *)title message:(NSString *)message;

@end
