//
//  UIAlertView+Blocks.m
//  WhichBanker
//
//  Created by 李伯坤 on 15/9/29.
//  Copyright (c) 2015年 lettai. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

static const void *OkButtonBlock = &OkButtonBlock;
static const void *CancelButtonBlock = &CancelButtonBlock;

@implementation UIAlertView (Blocks)

+ (void) showAlertViewWithTitle:(NSString *)title message:(NSString *)message;
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

- (id) initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitles cancelButtonBlock:(WBAlertViewBlock)cancelButtonBlock otherButtonBlock:(WBAlertViewBlock)otherButtonBlock
{
    if (self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil]) {
        self.tag = 0;
        objc_setAssociatedObject(self, OkButtonBlock, otherButtonBlock,OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, CancelButtonBlock, cancelButtonBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return self;
}

- (id) initWithTitle:(NSString *)title message:(NSString *)message placeholder:(NSString *)placeholder cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle cancelButtonBlock:(WBAlertViewBlock)cancelButtonBlock otherButtonBlock:(WBAlertViewTextBlock)otherButtonBlock
{
    if (self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil]) {
        self.tag = 1;
        objc_setAssociatedObject(self, OkButtonBlock, otherButtonBlock,OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, CancelButtonBlock, cancelButtonBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        self.alertViewStyle = UIAlertViewStylePlainTextInput;
        [[self textFieldAtIndex:0] setPlaceholder:placeholder];
    }
    return self;
}

- (void) alertView:(UIAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        WBAlertViewBlock block = objc_getAssociatedObject(self, CancelButtonBlock);
        if (block) {
            block();
        }
    }
    else if (buttonIndex == 1){
        if (theAlertView.tag == 0) {
            WBAlertViewBlock block = objc_getAssociatedObject(self, OkButtonBlock);
            if (block) {
                block();
            }
        }
        else {
            WBAlertViewTextBlock block = objc_getAssociatedObject(self, OkButtonBlock);
            if (block) {
                NSString *text = [theAlertView textFieldAtIndex:0].text;
                block(text);
            }
        }
    }
}

@end
