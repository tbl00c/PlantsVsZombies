//
//  PVZGameHelper.m
//  PlantsVsZombies
//
//  Created by 李伯坤 on 15/9/14.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZGameHelper.h"
#import "PVZDataHelper.h"

#import "PVZPlant.h"
#import "PVZCard.h"

static PVZGameHelper *gameHelper = nil;

@implementation PVZGameHelper

+ (PVZGameHelper *) sharedGameHelper
{
    if (gameHelper == nil) {
        gameHelper = [[PVZGameHelper alloc] init];
    }
    return gameHelper;
}

- (NSArray *) getAllCardsArray
{
    NSArray *cardInfoArray = [PVZDataHelper getArrayFromPlistByPlistName:@"Cards"];
    NSMutableArray *cardArray = [[NSMutableArray alloc] initWithCapacity:cardInfoArray.count];
    for (NSDictionary *dic in cardInfoArray) {
        PVZCard *card = [[PVZCard alloc] init];
        card.cardID = getIntValueByObject([dic objectForKey:@"CardID"]);
        card.cardName = [dic objectForKey:@"CardName"];
        card.imageName = [NSString stringWithFormat:@"Card_%@", card.cardName];
        card.cardChineseName = [dic objectForKey:@"CardChineseName"];
        card.cd = getFloatValueByObject([dic objectForKey:@"CD"]);
        card.cost = getIntValueByObject([dic objectForKey:@"Cost"]);
        [cardArray addObject:card];
    }
    
    return cardArray;
}

- (PVZPlant *) getPlantInfoByCardInfo:(PVZCard *)card
{
    PVZPlant *plant = [[PVZPlant alloc] init];
    plant.plantID = card.cardID;
    NSDictionary *dic = [PVZDataHelper getDictionaryFromPlistByPlistName:[NSString stringWithFormat:@"Plant_%d", plant.plantID]];
    if (dic == nil) {
        PVZLogWarning([self class], @"PVZGameHelper", @"读取植物%dPlist文件失败");
    }
    plant.plantName = [dic objectForKey:@"PlantName"];
    plant.hp = getFloatValueByObject([dic objectForKey:@"HP"]);
    plant.texturesDic = [dic objectForKey:@"Textures"];
    plant.hpTexturesArray = [dic objectForKey:@"HPTextures"];
    plant.timeTexturesArray = [dic objectForKey:@"TimeTexturesArray"];
    
    return plant;
}

@end
