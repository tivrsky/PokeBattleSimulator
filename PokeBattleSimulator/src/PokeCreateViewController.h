//
//  PokeCreateViewController.h
//  PokeBattleSimulator
//
//  Created by fukutarohori on 2013/07/12.
//  Copyright (c) 2013年 Fukutaro Hori. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PokeCreateViewControllerDelegate;
@interface PokeCreateViewController : UIViewController

@property (weak, nonatomic) id<PokeCreateViewControllerDelegate> delegate;

@end
