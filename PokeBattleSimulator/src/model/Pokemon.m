//
//  Pokemon.m
//  PokeBattleSimulator
//
//  Created by Fukutaro Hori on 2013/07/14.
//  Copyright (c) 2013年 Fukutaro Hori. All rights reserved.
//

#import <pthread_impl.h>
#import "Pokemon.h"

@implementation Pokemon

- (id)init {
    self = [super init];
    _No = 0;
    _Name = nil;
    _type1 = nil;
    _type2 = nil;
    _H = 0;
    _A = 0;
    _B = 0;
    _C = 0;
    _D = 0;
    _S = 0;
    return self;
}

@end
