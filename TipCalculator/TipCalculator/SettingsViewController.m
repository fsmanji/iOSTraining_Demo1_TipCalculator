//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Cristan Zhang on 9/11/15.
//  Copyright (c) 2015 FastTrack. All rights reserved.
//

#import "SettingsViewController.h"
#import "Constants.h"

@interface SettingsViewController  ()
@property (weak, nonatomic) IBOutlet UIPickerView *tipPicker;
@property (nonatomic) NSMutableArray* values;

@end

@implementation SettingsViewController

@synthesize values;
@synthesize tipPicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [tipPicker setDataSource:self];
    [tipPicker setDelegate:self];
    [tipPicker setShowsSelectionIndicator:YES];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    values = [defaults objectForKey:kTipValuesKey];
    NSInteger index = [defaults integerForKey:kDefaultTipIndexKey];
    if(index < 0 || index > [values count]) {
        index = 1;
    }
    
    [tipPicker selectRow:index inComponent:0 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 * UIPIckerViewDataSource
 */

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [values count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    float currentTip = [values[row] floatValue];
    return [NSString stringWithFormat:kTipRateFormat, currentTip * 100];
}

/**
 * UIPIckerDelegate
 */

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //save selected tip to User Defaults
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:values[row] forKey:kDefaultTipRateKey];
    [defaults setInteger:row forKey:kDefaultTipIndexKey];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
