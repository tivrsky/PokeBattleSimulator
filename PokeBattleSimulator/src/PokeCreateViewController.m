//
//  PokeCreateViewController.m
//  PokeBattleSimulator
//
//  Created by fukutarohori on 2013/07/12.
//  Copyright (c) 2013年 Fukutaro Hori. All rights reserved.
//

#import "PokeCreateViewController.h"
#import "UIView+MyExtension.h"

@interface PokeCreateViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *nameButton;


@end

@implementation PokeCreateViewController

UIPickerView *namePickerView;
NSMutableArray *array1;


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
    NSLog(@"tabbarHeight %d", tabbarHeight);
    
    namePickerView = [[UIPickerView alloc] init];
    namePickerView.y = self.view.height - namePickerView.height - tabbarHeight;
    namePickerView.showsSelectionIndicator = YES;
    namePickerView.delegate = self;
    namePickerView.dataSource = self;

    array1 = [NSArray arrayWithObjects:@"ミジュマル",@"クルミル",@"ダルマッカ", nil];
}

/* PickerView */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [array1 count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [array1 objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_nameButton setTitle:[array1 objectAtIndex:row] forState:UIControlStateNormal];
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
