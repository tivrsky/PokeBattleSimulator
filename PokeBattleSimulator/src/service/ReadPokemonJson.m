//
//  ReadPokemonJson.m
//  PokeBattleSimulator
//
//  Created by Fukutaro Hori on 2013/09/02.
//  Copyright (c) 2013年 Fukutaro Hori. All rights reserved.
//

#import "ReadPokemonJson.h"
#import "Pokemon.h"

@implementation ReadPokemonJson

NSMutableArray *pokeArray;
NSMutableDictionary *pokeDictionary;

- (id)init {
    pokeArray = [[NSMutableArray alloc] init];
    pokeDictionary = [[NSMutableDictionary alloc] init];
//    Pokemon *pokemon0 = [[Pokemon alloc] init];
//    [pokemon0 setName:@"ポケモン名"];
//    [pokeDictionary setObject:pokemon0 forKey:0];

    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:@"pokemon" ofType:@"json"];
    NSLog(@"path %@", filePath);
    NSData *pokemonJsonData = [NSData dataWithContentsOfFile:filePath];

    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:pokemonJsonData options:NSJSONReadingAllowFragments error:&error];

    for (NSDictionary *obj in array) {
        Pokemon *pokemon = [[Pokemon alloc] init];
        pokemon.Name = [obj valueForKey:@"名前"];

        NSString *typeString = [obj valueForKey:@"タイプ"];
        NSArray *typeArray = [typeString componentsSeparatedByString:@"/"];
        pokemon.type1 = [typeArray objectAtIndex:0];
        if ([typeArray count] > 1) {
            pokemon.type2 = [typeArray objectAtIndex:1];
        }

        pokemon.No = [(NSString *)[obj valueForKey:@"No"] intValue];
        pokemon.H = [(NSString *)[obj valueForKey:@"HP"] intValue];
        pokemon.A = [(NSString *)[obj valueForKey:@"こうげき"] intValue];
        pokemon.B = [(NSString *)[obj valueForKey:@"ぼうぎょ"] intValue];
        pokemon.C = [(NSString *)[obj valueForKey:@"とくこう"] intValue];
        pokemon.D = [(NSString *)[obj valueForKey:@"とくぼう"] intValue];
        pokemon.S = [(NSString *)[obj valueForKey:@"すばやさ"] intValue];

        [pokeArray addObject:pokemon];
        [pokeDictionary setObject:pokemon forKey:[NSString stringWithFormat:@"%d", pokemon.No]];
    }
    return self;
}

- (NSMutableArray *)getPokemonArray
{
    return pokeArray;
}

- (NSMutableDictionary *)getPokemonDictionary {
    return pokeDictionary;
}

@end
