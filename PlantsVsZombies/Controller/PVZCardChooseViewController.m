//
//  PVZCardChooseViewController.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/15.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZCardChooseViewController.h"
#import "PVZCardCell.h"

@interface PVZCardChooseViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) int chooseCount;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation PVZCardChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setText:@"选择植物"];
    [_titleLabel setBackgroundColor:[UIColor blackColor]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:_titleLabel];
    
    _closeButton = [[UIButton alloc] init];
    [_closeButton setTitle:@"x" forState:UIControlStateNormal];
    [_closeButton setBackgroundColor:[UIColor redColor]];
    [_closeButton.layer setMasksToBounds:YES];
    [_closeButton addTarget:self action:@selector(closeButtonDown) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_closeButton];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(WIDTH_CARDMENU, HEIGHT_CARDITEM)];
    [flowLayout setSectionInset:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [_collectionView registerClass:[PVZCardCell class] forCellWithReuseIdentifier:@"CardCell"];
    [self.view addSubview:_collectionView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    CGRect rect = self.view.frame;
    [_titleLabel setFrame:CGRectMake(0, 0, rect.size.width, 24)];
    [_closeButton setFrame:CGRectMake(rect.size.width - 18, 4, 16, 16)];
    [_closeButton.layer setCornerRadius:8];
    [_collectionView setFrame:CGRectMake(0, 24, rect.size.width, rect.size.height - 24)];
    
    [_collectionView reloadData];
}

- (void) setCardsArray:(NSArray *)array andChooseCount:(int)count
{
    _data = [[NSMutableArray alloc] initWithArray:array];
    [self setChooseCount:count];
}

- (void) reAddCard:(PVZCard *)card
{
    [self setChooseCount:_chooseCount + 1];
    [_data insertObject:card atIndex:0];
    [_collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
}

- (void) setChooseCount:(int)chooseCount
{
    _chooseCount = chooseCount;
    [_titleLabel setText:[NSString stringWithFormat:@"选择植物(%d)", chooseCount]];
}

- (void) closeButtonDown
{
    if (_chooseCount == 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(cardChooseVCCloseButtonDown)]) {
            [_delegate cardChooseVCCloseButtonDown];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你还可以选择另外的%d种植物，是否放弃选择并开始游戏?", _chooseCount] delegate:self cancelButtonTitle:@"放弃选择" otherButtonTitles:@"继续选择", nil];
        [alert show];
    }
}

#pragma mark - UICollectionView
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _data.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PVZCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCell" forIndexPath:indexPath];
    PVZCard *card = [_data objectAtIndex:indexPath.row];
    [cell setCard:card];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_chooseCount == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能再多了，亲～" delegate:nil cancelButtonTitle:@"好吧" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [self setChooseCount:_chooseCount - 1];
    PVZCard *card = [_data objectAtIndex:indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(cardChooseVCDidSelectCard:)]) {
        [_delegate cardChooseVCDidSelectCard:card];
    }
    [_data removeObject:card];
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(cardChooseVCCloseButtonDown)]) {
            [_delegate cardChooseVCCloseButtonDown];
        }
    }
}


@end
