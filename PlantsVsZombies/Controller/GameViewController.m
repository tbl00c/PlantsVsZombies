//
//  GameViewController.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/29.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
    
    GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
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
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
