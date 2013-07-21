//
//  PokeCreateViewController.m
//  PokeBattleSimulator
//
//  Created by fukutarohori on 2013/07/12.
//  Copyright (c) 2013年 Fukutaro Hori. All rights reserved.
//

#import "PokeCreateViewController.h"
#import "UIView+MyExtension.h"
#import "Pokemon.h"

@interface PokeCreateViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *nameButton;



@end

@implementation PokeCreateViewController

UIPickerView *namePickerView;
NSMutableArray *pokeArray;
NSMutableDictionary *pokeDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"PokeCreateViewController viewDidLoad");

    NSInteger tabbarHeight = [[[self tabBarController]rotatingFooterView] frame].size.height;

    namePickerView = [[UIPickerView alloc] init];
    namePickerView.y = self.view.height - namePickerView.height - tabbarHeight;
    namePickerView.showsSelectionIndicator = YES;
    namePickerView.shouldGroupAccessibilityChildren = YES;
    namePickerView.translatesAutoresizingMaskIntoConstraints = YES;
    namePickerView.userInteractionEnabled = YES;
    namePickerView.delegate = self;
    namePickerView.dataSource = self;
    
    pokeArray = [[NSMutableArray alloc] init];
//    NSString *jsonPokeNames = @"["
//            "{\"No\":641,\"名前\":\"トルネロス\",\"HP\":79,\"こうげき\":115,\"ぼうぎょ\":70,\"とくこう\":125,\"とくぼう\":80,\"すばやさ\":111,\"タイプ\":\"ひこう\"},\n"
//            "  {\"No\":642,\"名前\":\"ボルトロス\",\"HP\":79,\"こうげき\":115,\"ぼうぎょ\":70,\"とくこう\":125,\"とくぼう\":80,\"すばやさ\":111,\"タイプ\":\"でんき/ひこう\"}"
//            "]";
//
//    NSData *pokeNamesData = [jsonPokeNames dataUsingEncoding:NSUnicodeStringEncoding];
    //    NSArray *array = [NSJSONSerialization JSONObjectWithData:pokeNamesData options:NSJSONReadingAllowFragments error:&error];
    // file load
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:@"pokemon" ofType:@"json"];
    NSLog(@"path %@", filePath);
    NSData *pokemonJsonData = [NSData dataWithContentsOfFile:filePath];

    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:pokemonJsonData options:NSJSONReadingAllowFragments error:&error];

    pokeDictionary = [[NSMutableDictionary alloc] init];

    for (NSDictionary *obj in array) {
        Pokemon *pokemon = [[Pokemon alloc] init];
        pokemon.Name = [obj valueForKey:@"名前"];

//        pokemon.type = [obj valueForKey:@"タイプ"];
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

}

/* PickerView */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pokeDictionary count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Pokemon *pokemon = [pokeArray objectAtIndex:row];
    return [NSString stringWithFormat:@"%d : %@",pokemon.No, pokemon.Name];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    Pokemon *pokemon = [pokeArray objectAtIndex:row];
    [_nameButton setTitle:pokemon.Name forState:UIControlStateNormal];
}

- (IBAction)PokeName:(id)sender {
    NSLog(@"PushButton");
    [self.view addSubview:namePickerView];
}

/* pickerclose */
- (IBAction)closeButton:(id)sender {
    NSLog(@"Close");
    [namePickerView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
