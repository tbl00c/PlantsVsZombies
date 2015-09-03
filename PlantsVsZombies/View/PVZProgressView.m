//
//  PVZProgressView.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/3.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZProgressView.h"

@interface PVZProgressView ()
{
    float grassHeight;
    float tagWidth;
}

@property (nonatomic, strong) UIImageView *grassImageView;
@property (nonatomic, strong) UIImageView *tagImageView;
@property (nonatomic, strong) UIView *tagView;

@end

@implementation PVZProgressView

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _grassImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fp_grass"]];
        [_grassImageView setClipsToBounds:YES];
        [_grassImageView setContentMode: UIViewContentModeTopLeft];
        [self addSubview:_grassImageView];
        
        _tagView = [[UIView alloc] init];
        [self addSubview:_tagView];
        
        _tagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fp_tag"]];
        
        [_tagView addSubview:_tagImageView];
    }
    return self;
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    grassHeight = frame.size.height * 0.6;
    [_grassImageView setFrame:CGRectMake(0, frame.size.height - grassHeight, 0, grassHeight + 10)];
    
    tagWidth = frame.size.height * 0.9;
    [_tagView setSize:CGSizeMake(tagWidth, tagWidth)];
    
    [_tagImageView setFrame:_tagView.frame];
    
    [self setProgress:0];
}

/**
 *  设置加载进度
 *
 *  @param progress 进度（0 ～ 1.0）
 */
- (void) setProgress:(float)progress
{
    if (progress >= 1.0) {
        [_tagImageView removeFromSuperview];
        return;
    }
    [_grassImageView setFrameWidth:(self.frameWidth - 5) * progress];
    
    float w = tagWidth * sin(M_PI_2 * (1.0 - progress * 0.8));
    [_tagImageView setSize:CGSizeMake(w, w)];
    [_tagImageView setCenter:CGPointMake(18, 18)];
    
    CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformMakeRotation(0), progress * M_PI * 3);
    [_tagView setTransform:transform];
    [_tagView setCenter:CGPointMake(_grassImageView.frameWidth + w * 0.3 - 2, _grassImageView.originY + grassHeight - w * 0.5)];
}

@end
