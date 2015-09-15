//
//  PVZCardCell.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/15.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZCardCell.h"

@implementation PVZCardCell

- (void) layoutSubviews
{
    [self.imageView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.costLabel setFrame:CGRectMake(self.frame.size.width * 0.5, self.frame.size.height * 0.65, self.frame.size.width * 0.4, self.size.height * 0.25)];
}

- (UIImageView *) imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *) costLabel
{
    if (_costLabel == nil) {
        _costLabel = [[UILabel alloc] init];
        [_costLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [_costLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_costLabel];
    }
    return _costLabel;
}

- (void) setCard:(PVZCard *)card
{
    [self.imageView setImage:[UIImage imageNamed:card.imageName]];
    [self.costLabel setText:[NSString stringWithFormat:@"%d", card.cost]];
}

@end
