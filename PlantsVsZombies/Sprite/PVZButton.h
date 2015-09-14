//
//  SKButton.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/3.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PVZButton : SKNode

@property (nonatomic, weak) id skTarget;
@property (nonatomic, assign) SEL skAction;
@property (nonatomic, assign) NSUInteger tag;

@property (nonatomic, strong) SKColor *fontColor;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) NSString *fontName;

@property (nonatomic, assign) CGSize size;

- (id) initWithTitle:(NSString *)title;
- (id) initWithImageName:(NSString *)imageName;
- (void) setTitle:(NSString *)title;
- (void) setImageNamed:(NSString *)imageName;
- (void) addTarget:(id)target action:(SEL)action;

@end
