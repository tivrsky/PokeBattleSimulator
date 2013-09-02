//
//  ReadPokemonJson.h
//  PokeBattleSimulator
//
//  Created by Fukutaro Hori on 2013/09/02.
//  Copyright (c) 2013年 Fukutaro Hori. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadPokemonJson : NSObject

- (NSMutableArray *)getPokemonArray;
- (NSMutableDictionary *) getPokemonDictionary;
@end
