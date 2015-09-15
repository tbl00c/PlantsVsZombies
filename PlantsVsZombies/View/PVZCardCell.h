//
//  PVZCardCell.h
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/15.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PVZCard.h"

@interface PVZCardCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *costLabel;

@property (nonatomic, strong) PVZCard *card;

@end
