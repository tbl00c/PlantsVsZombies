//
//  GameViewController.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/29.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "GameViewController.h"

#import "PVZAudioPlayer.h"

#import "FirstScene.h"

@interface GameViewController ()
{
    NSTimer *testTimer;
}

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIImageView *floorImageView;
@property (nonatomic, strong) UIImageView *progressImageView;
@property (nonatomic, strong) UIImageView *tagImageView;
@property (nonatomic, strong) UIView *tagView;
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
    
    _progressImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fp_grass"]];
    [_progressImageView setClipsToBounds:YES];
    [_progressImageView setContentMode: UIViewContentModeTopLeft];
    [_progressImageView setHidden:YES];
    [self.view addSubview:_progressImageView];
    
    _tagView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    [_tagView setHidden:YES];
    [self.view addSubview:_tagView];
    
    _tagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fp_tag"]];
    [_tagImageView setFrame:_tagView.frame];
    [_tagView addSubview:_tagImageView];
    
    _startButton = [[UIButton alloc] init];
    [_startButton setHidden:YES];
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
            [_startButton setFrame:_floorImageView.frame];
            [_progressImageView setFrame:CGRectMake(_floorImageView.originX - 5, _floorImageView.originY - 17, 0, 27)];
            [_progressImageView setHidden:NO];
            [_tagView setCenter:CGPointMake(_progressImageView.originX + _progressImageView.frameWidth + _tagImageView.frameWidth * 0.5, _progressImageView.originY + _progressImageView.frameHeight - 36 * 0.5)];
            [_tagView setHidden:NO];
            
            // 开始进度条动画
            testTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(testProgress) userInfo:nil repeats:YES];
        }];
    });
}

- (void) startButtonDown
{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
    
    GameScene *scene = [GameScene unarchiveFromFile:@"FirstScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
}

static float a = 0;
- (void) testProgress
{
    a += 0.5;
    [self setProgress:a / 150.0];
    if (a >= 150.0) {
        [testTimer invalidate];
    }
}

- (void) setProgress:(float)progress
{
    if (progress >= 1.0) {
        [_tagImageView removeFromSuperview];
        [_startButton setHidden:NO];
        return;
    }
    [_progressImageView setFrameWidth:(_floorImageView.frameWidth - 5) * progress];
    
    float w = 36 * sin(M_PI_2 * (1.0 - progress * 0.8));
    [_tagImageView setSize:CGSizeMake(w, w)];
    [_tagImageView setCenter:CGPointMake(18, 18)];
    
    CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformMakeRotation(0), progress * M_PI * 3);
    [_tagView setTransform:transform];
    float x = _progressImageView.originX + _progressImageView.frameWidth + w * 0.3;
    float y = _progressImageView.originY + _progressImageView.frameHeight - w * 0.5;
    [_tagView setCenter:CGPointMake(x, y)];
}

- (void) showStartButton
{

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
