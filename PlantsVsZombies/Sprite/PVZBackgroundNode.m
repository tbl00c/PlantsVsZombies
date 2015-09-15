//
//  PVZLawn.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/10.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZBackgroundNode.h"

static PVZBackgroundNode *backgroundNode = nil;

@interface PVZBackgroundNode ()
{
    id map[5][9];
}

@property (nonatomic, assign) CGRect plantsRect;            // 植物放置区域
@property (nonatomic, assign) CGSize plantItemSize;         // 单个植物大小

@end

@implementation PVZBackgroundNode

+ (PVZBackgroundNode *) createBackgroundNode
{
    if (backgroundNode != nil) {
        [backgroundNode removeFromParent];
    }
    backgroundNode = [PVZBackgroundNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(HEIGHT_SCREEN * 7 / 3, HEIGHT_SCREEN)];
    [backgroundNode setUserInteractionEnabled:YES];
    return backgroundNode;
}

/**
 *  根据地图类型划分植物放置区域
 *
 *  @param type 地图类型
 */
- (void) setType:(PVZBackgroundType)type
{
    NSString *imageName = [NSString stringWithFormat:@"PVZBackground_%ld.jpg", (long)type];
    [self setTexture:[SKTexture textureWithImageNamed:imageName]];
    switch (type) {
        case PVZBackgroundLawnEmpty:
            _plantItemSize = CGSizeMake(0, 0);
            _plantsRect = CGRectMake(0, 0, 0, 0);
            break;
        case PVZBackgroundLawnOne:
            _plantItemSize = CGSizeMake(50, 60);
            _plantsRect = CGRectMake(-280, -45, _plantItemSize.width * 9, _plantItemSize.height);
            break;
        case PVZBackgroundLawnThree:
            _plantItemSize = CGSizeMake(50, 60);
            _plantsRect = CGRectMake(-280, -105, _plantItemSize.width * 9, _plantItemSize.height * 3);
            break;
        case PVZBackgroundLawn:
            _plantItemSize = CGSizeMake(50, 60);
            _plantsRect = CGRectMake(-280, -165, _plantItemSize.width * 9, _plantItemSize.height * 5);
            break;
        case PVZBackgroundLawnDark:
            _plantItemSize = CGSizeMake(50, 60);
            _plantsRect = CGRectMake(-280, -165, _plantItemSize.width * 9, _plantItemSize.height * 5);
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

/**
 *  展示本局的僵尸
 *
 *  @param zombies 僵尸数组
 */
- (void) scrollToShowZombies:(NSArray *)zombies
{
    CGPoint startPoint = self.position;
    CGPoint endPoint = CGPointMake(startPoint.x - (self.size.width - WIDTH_SCREEN), startPoint.y);
    SKAction *moveToRight = [SKAction moveTo:endPoint duration:1];
    SKAction *wait = [SKAction waitForDuration:1];
    SKAction *moveBack = [SKAction moveTo:startPoint duration:1];
    SKAction *action = [SKAction sequence:@[moveToRight, wait, moveBack]];
    [self runAction:action];
}

/**
 *  在制定位置放置植物
 *
 *  @param point 位置
 *  @param plant 植物
 *
 *  @return 放置是否成功
 */
- (BOOL) putPlantAtPoint:(CGPoint)point plant:(id)plant
{
    int x = point.x;
    int y = point.y;
    if (map[y][x] != nil) {
        return NO;
    }
    map[y][x] = plant;
    CGPoint mapPoint = [self getPlantItemPostionByMapPoint:point];
    [plant setPosition: mapPoint];
    [self addChild:plant];
    
    return YES;
}

#pragma mark - 点击事件及处理

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInNode:self];
    CGPoint plantPoint = [self getPlantItemMapPositionByTouchPoint:point];
    BOOL canPutPlant = YES;
    if (plantPoint.x == -1 && plantPoint.y == -1) {
        canPutPlant = NO;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(backgroundNodeClickedAtPoint:canPutPlant:)]) {
        [_delegate backgroundNodeClickedAtPoint:plantPoint canPutPlant:canPutPlant];
    }
}

- (CGPoint) getPlantItemMapPositionByTouchPoint:(CGPoint)point
{
    if (point.x >= _plantsRect.origin.x && point.x < _plantsRect.origin.x + _plantsRect.size.width && point.y >= _plantsRect.origin.y && point.y < _plantsRect.origin.y + _plantsRect.size.height) {
        int x = (point.x - _plantsRect.origin.x) / _plantItemSize.width;
        int y = (point.y - _plantsRect.origin.y) / _plantItemSize.height;
        return map[y][x] == nil ? CGPointMake(x, y) : CGPointMake(-1, -1);
    }
    return CGPointMake(-1, -1);
}

- (CGPoint) getPlantItemPostionByMapPoint:(CGPoint)point
{
    float x = _plantsRect.origin.x + (point.x + 0.5) * _plantItemSize.width;
    float y = _plantsRect.origin.y + (point.y + 0.5) * _plantItemSize.height;
    return CGPointMake(x, y);
}

@end
