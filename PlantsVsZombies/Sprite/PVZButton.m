//
//  SKButton.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/3.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZButton.h"

@interface PVZButton ()

@property (nonatomic, strong) SKLabelNode *labelNode;
@property (nonatomic, strong) SKSpriteNode *imageNode;

@end

@implementation PVZButton

- (id) initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        _labelNode = [SKLabelNode labelNodeWithText:title];
        _labelNode.fontColor = [SKColor blackColor];
        _labelNode.fontSize = 18;
        [self addChild:_labelNode];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (id) initWithImageName:(NSString *)imageName
{
    if(self = [super init]){
        _imageNode = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        [self addChild:_imageNode];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void) setTitle:(NSString *)title
{
    [_labelNode setText:title];
}

- (void) setImageNamed:(NSString *)imageName
{
    [_imageNode setTexture:[SKTexture textureWithImageNamed:imageName]];
}

- (void) addTarget:(id)target action:(SEL)action
{
    _skTarget = target;
    _skAction = action;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_skAction && _skTarget) {
        SuppressPerformSelectorLeakWarning([_skTarget performSelector:_skAction withObject:self]);
    }
}

#pragma mark - Text Button
- (void) setFontColor:(UIColor *)fontColor
{
    [_labelNode setFontColor:fontColor];
}

- (void) setFontSize:(CGFloat)fontSize
{
    [_labelNode setFontSize:fontSize];
}

- (void) setFontName:(NSString *)fontName
{
    [_labelNode setFontName:fontName];
}

#pragma mark - Image Button

- (void) setSize:(CGSize)size
{
    [_imageNode setSize:size];
}

@end
