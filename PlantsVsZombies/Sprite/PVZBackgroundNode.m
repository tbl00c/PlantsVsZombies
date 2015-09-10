//
//  PVZLawn.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/10.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZBackgroundNode.h"

static PVZBackgroundNode *backgroundNode = nil;

@implementation PVZBackgroundNode

+ (PVZBackgroundNode *) createBackgroundNodeByType: (PVZBackgroundType) type
{
    if (backgroundNode != nil) {
        [backgroundNode removeFromParent];
    }
    NSString *imageName = [NSString stringWithFormat:@"PVZBackground_%ld.jpg", (long)type];
    backgroundNode = [PVZBackgroundNode spriteNodeWithImageNamed:imageName];
    [backgroundNode setType:type];
    return backgroundNode;
}

- (void) setType:(PVZBackgroundType)type
{
    [self setSize:CGSizeMake(HEIGHT_SCREEN * 7 / 3, HEIGHT_SCREEN)];
    switch (type) {
        case PVZBackgroundLawnEmpty:
     
            break;
        case PVZBackgroundLawnOne:
            
            break;
        case PVZBackgroundLawnThree:
            
            break;
        case PVZBackgroundLawn:
            
            break;
        case PVZBackgroundLawnDark:
            
            break;
        case PVZBackgroundRoof:
            
            break;
        case PVZBackgroundRoofDark:
            
            break;
        case PVZBackgroundPool:
            
            break;
        case PVZBackgroundPoolDark:
            
            break;
        default:
            break;
    }
}

- (void) scrollToShowZombies:(NSArray *)zombies;
{
    CGPoint startPoint = self.position;
    CGPoint endPoint = CGPointMake(startPoint.x - (self.size.width - WIDTH_SCREEN), startPoint.y);
    SKAction *moveToRight = [SKAction moveTo:endPoint duration:1];
    SKAction *wait = [SKAction waitForDuration:1];
    SKAction *moveBack = [SKAction moveTo:startPoint duration:1];
    SKAction *action = [SKAction sequence:@[moveToRight, wait, moveBack]];
    [self runAction:action];
}

@end
