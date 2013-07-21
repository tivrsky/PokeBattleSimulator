//
//  Pokemon.h
//  PokeBattleSimulator
//
//  Created by Fukutaro Hori on 2013/07/14.
//  Copyright (c) 2013年 Fukutaro Hori. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pokemon : NSObject

@property(nonatomic, assign) NSInteger No;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *type1;
@property (nonatomic, copy) NSString *type2;
@property(nonatomic, assign) NSInteger H;
@property(nonatomic, assign) NSInteger A;
@property(nonatomic, assign) NSInteger B;
@property(nonatomic, assign) NSInteger C;
@property(nonatomic, assign) NSInteger D;
@property(nonatomic, assign) NSInteger S;

@end
