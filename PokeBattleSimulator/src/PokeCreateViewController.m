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

@interface PokeCreateViewController () <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *nameButton;

@property (weak, nonatomic) IBOutlet UITextField *actualHP;
@property (weak, nonatomic) IBOutlet UITextField *actualA;
@property (weak, nonatomic) IBOutlet UITextField *actualB;
@property (weak, nonatomic) IBOutlet UITextField *actualC;
@property (weak, nonatomic) IBOutlet UITextField *actualD;
@property (weak, nonatomic) IBOutlet UITextField *actualS;

@property (weak, nonatomic) IBOutlet UITextField *ivHp;
@property (weak, nonatomic) IBOutlet UITextField *ivA;
@property (weak, nonatomic) IBOutlet UITextField *ivB;
@property (weak, nonatomic) IBOutlet UITextField *ivC;
@property (weak, nonatomic) IBOutlet UITextField *ivD;
@property (weak, nonatomic) IBOutlet UITextField *ivS;

@property (weak, nonatomic) IBOutlet UITextField *evHp;
@property (weak, nonatomic) IBOutlet UITextField *evA;
@property (weak, nonatomic) IBOutlet UITextField *evB;
@property (weak, nonatomic) IBOutlet UITextField *evC;
@property (weak, nonatomic) IBOutlet UITextField *evD;
@property (weak, nonatomic) IBOutlet UITextField *evS;

@property (weak, nonatomic) IBOutlet UIScrollView *uiScrollView;


@end

@implementation PokeCreateViewController

UIActionSheet *uiActionSheet;
UIPickerView *namePickerView;
NSMutableArray *pokeArray;
NSMutableDictionary *pokeDictionary;
UIToolbar *pokeToolBar;
UITextField *uiTextField;

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

    _actualHP.delegate = self;
    _actualA.delegate = self;
    _actualB.delegate = self;
    _actualC.delegate = self;
    _actualD.delegate = self;
    _actualS.delegate = self;

    _ivHp.delegate = self;
    _ivA.delegate = self;
    _ivB.delegate = self;
    _ivC.delegate = self;
    _ivD.delegate = self;
    _ivS.delegate = self;

    _evHp.delegate = self;
    _evA.delegate = self;
    _evB.delegate = self;
    _evC.delegate = self;
    _evD.delegate = self;
    _evS.delegate = self;


    //NSInteger tabBarHeight = [[[self tabBarController]rotatingFooterView] frame].size.height;

    uiActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    uiActionSheet.delegate = self;

    pokeToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [pokeToolBar sizeToFit];

    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButton)];
    [pokeToolBar setItems:[NSArray arrayWithObjects:spacer, done, nil]];


    //[uiTextField addSubview:pokeToolBar];
    [uiActionSheet addSubview:pokeToolBar];

    namePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    //namePickerView.y = self.view.height - namePickerView.height - tabBarHeight;
    namePickerView.showsSelectionIndicator = YES;
    namePickerView.shouldGroupAccessibilityChildren = YES;
    namePickerView.translatesAutoresizingMaskIntoConstraints = YES;
    namePickerView.userInteractionEnabled = YES;
    namePickerView.delegate = self;
    namePickerView.dataSource = self;
    [uiActionSheet addSubview:namePickerView];
    
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

    // keyboard's height
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //[notificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    CGRect keyboardFrameEnd = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    float screenHeight = screenBounds.size.height;

    if ((uiTextField.frame.origin.y + uiTextField.frame.size.height) > (screenHeight - keyboardFrameEnd.size.height - 20)) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             _uiScrollView.frame = CGRectMake(0, screenHeight - uiTextField.frame.origin.y - keyboardFrameEnd.size.height + 20, _uiScrollView.frame.size.width, _uiScrollView.frame.size.height);
                         }];
    }
}

- (void)keyboardWillHide: (NSNotification *)notification {

}

/* PickerView */
- (void)doneButton {
    [uiActionSheet dismissWithClickedButtonIndex:0 animated:YES];

    [UIView animateWithDuration:0.3
                     animations:^{
                         _uiScrollView.frame = CGRectMake(0, 0, _uiScrollView.frame.size.width, _uiScrollView.frame.size.height);
                     }];
    [uiTextField resignFirstResponder];
}

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

    [self setParameter:pokemon];
}


/* Calculation */
- (void) setParameter: (Pokemon*)pokemon {
    //{(種族値×2＋個体値＋努力値/4)×Lv/100}＋10＋Lv
    NSInteger actualHp = (int)(floor(pokemon.H * 2 + [_ivHp.text intValue] + ([_evHp.text intValue]/4) ) * 50/100 ) + 10 + 50;
    [_actualHP setText:[NSString stringWithFormat:@"%d",actualHp]];

    NSInteger actualA = [self calculationParameter:pokemon.A :[_ivA.text intValue] :[_evA.text intValue]];
    [_actualA setText:[NSString stringWithFormat:@"%d", actualA]];
    NSInteger actualB = [self calculationParameter:pokemon.B :[_ivB.text intValue] :[_evB.text intValue]];
    [_actualB setText:[NSString stringWithFormat:@"%d", actualB]];
    NSInteger actualC = [self calculationParameter:pokemon.C :[_ivC.text intValue] :[_evC.text intValue]];
    [_actualC setText:[NSString stringWithFormat:@"%d", actualC]];
    NSInteger actualD = [self calculationParameter:pokemon.D :[_ivD.text intValue] :[_evD.text intValue]];
    [_actualD setText:[NSString stringWithFormat:@"%d", actualD]];
    NSInteger actualS = [self calculationParameter:pokemon.S :[_ivS.text intValue] :[_evS.text intValue]];
    [_actualS setText:[NSString stringWithFormat:@"%d", actualS]];
}

- (NSInteger)calculationParameter:(int)baseParam :(int)iv :(int)ev {
    // [{(種族値×2＋個体値＋努力値/4)×Lv/100}＋5]×性格補正(1.1、1.0、0.9)
    return (int) floor((floor(baseParam * 2 + iv + (ev / 4)) * 50 / 100 + 5 * 1));
}

/* Push buttons */
- (IBAction)PokeName:(id)sender {
    NSLog(@"PushButton");
    //[self.view addSubview:namePickerView];
    [uiActionSheet showInView:self.view];
    [uiActionSheet setBounds:CGRectMake(0, 0, 320, 464)];
}

- (IBAction)addEvHp:(id)sender {
    [_evHp setText:@"252"];
}
- (IBAction)addEvA:(id)sender {
    [_evA setText:@"252"];
}
- (IBAction)addEvB:(id)sender {
    [_evB setText:@"252"];
}
- (IBAction)addEvC:(id)sender {
    [_evC setText:@"252"];
}
- (IBAction)addEvD:(id)sender {
    [_evD setText:@"252"];
}
- (IBAction)addEvS:(id)sender {
    [_evS setText:@"252"];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldShouldBeginEditing");
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.inputAccessoryView = pokeToolBar;
    uiTextField = textField;
    return YES;
}

/* picker close */
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
