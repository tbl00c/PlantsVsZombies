//
//  GameViewController.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/29.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "GameViewController.h"
#import "PVZProgressView.h"
#import "RootScene.h"

#import "PVZAudioPlayer.h"

#import "AdventureModeScene.h"

@interface GameViewController ()
{
    NSTimer *testTimer;
}

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIImageView *floorImageView;
@property (nonatomic, strong) PVZProgressView *progressView;
@property (nonatomic, strong) UIButton *startButton;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoadingPage"]];
    [_bgImageView setBackgroundColor:[UIColor redColor]];
    [_bgImageView setFrame:self.view.frame];
    [self.view addSubview:_bgImageView];
    
    _titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fp_title"]];
    [_titleImageView setSize:CGSizeMake(374 * 1.1, 62 * 1.1)];
    [_titleImageView setCenter:CGPointMake(WIDTH_SCREEN / 2.0, - 62 * 1.2)];
    [self.view addSubview:_titleImageView];
    
    _floorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fp_floor"]];
    [_floorImageView setSize:CGSizeMake(320 * 0.8, 53 * 0.8)];
    [_floorImageView setCenter:CGPointMake(WIDTH_SCREEN / 2.0, HEIGHT_SCREEN + 53 * 0.8)];
    [self.view addSubview:_floorImageView];
    
    _progressView = [[PVZProgressView alloc] init];
    [_progressView setHidden:YES];
    [self.view addSubview:_progressView];
    
    _startButton = [[UIButton alloc] init];
    [_startButton setHidden:NO];
    [_startButton setAlpha:0];
    [_startButton setTitle:@"Click To Start Game" forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(startButtonDown) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_startButton];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 播放音乐
    [[PVZAudioPlayer sharedAudioPlayer] playMusicByName:@"game3.mp3" loop:YES];
    
//    [self showInitView];        // 正常进入
    [self startButtonDown];     // 直接进入主页面
}

/**
 *  现实加载视图和动画
 */
- (void) showInitView
{
    // 标题动画
    [UIView animateWithDuration:1.0 animations:^{
        [_titleImageView setCenter:CGPointMake(WIDTH_SCREEN / 2.0, HEIGHT_SCREEN / 6.5)];
    } completion:^(BOOL finished) {
        
    }];
    // 底部动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.0 animations:^{
            [_floorImageView setCenter:CGPointMake(WIDTH_SCREEN / 2.0, HEIGHT_SCREEN - 53)];
        } completion:^(BOOL finished) {
            [_startButton setFrame:CGRectMake(_floorImageView.originX, _floorImageView.originY, _floorImageView.frameWidth, _floorImageView.frameHeight * 0.9)];
            [_progressView setFrame:CGRectMake(_floorImageView.originX - 5, _floorImageView.originY - 32, _floorImageView.frameWidth, 40)];
            [_progressView setHidden:NO];
            
            // 开始进度条动画(测试用)
            testTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(testProgress) userInfo:nil repeats:YES];
        }];
    });

}

/**
 *  测试进度条
 */
static float a = 0;
- (void) testProgress
{
    a += 0.5;
    [_progressView setProgress:a / 150.0];
    if (a >= 150.0) {
        [testTimer invalidate];
        [_startButton setHidden:NO];
        [UIView animateWithDuration:0.5 animations:^{
            [_startButton setAlpha:1.0];
        }];
    }
}

/**
 *  开始游戏按钮
 */
- (void) startButtonDown
{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
    
//    RootScene *scene = [RootScene sceneWithSize:CGSizeMake(667, 375)];
    AdventureModeScene *scene = [AdventureModeScene sceneWithSize:CGSizeMake(667, 375)];
    scene.scaleMode = SKSceneScaleModeAspectFit;
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
