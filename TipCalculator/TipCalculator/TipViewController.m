//
//  ViewController.m
//  TipCalculator
//
//  Created by Cristan Zhang on 9/11/15.
//  Copyright (c) 2015 FastTrack. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"
#import "Constants.h"


@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billInput;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipSegmentView;
@property (weak, nonatomic) IBOutlet UILabel *tipRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (nonatomic) NSArray* tipValues;

- (IBAction)onTapOutside:(id)sender;
- (IBAction)onBillChanged:(id)sender;

- (void) updateValues;
- (void) onSettingsButton;

@end

@implementation TipViewController

@synthesize tipValues;
@synthesize tipRateLabel;
@synthesize tipSegmentView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.title = @"Tip Calculator";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //add settings item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    //[self updateFromSettings];

}

- (void)updateFromSettings {
    //load defaults value
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    tipValues = [defaults objectForKey:kTipValuesKey];
    
    //load default segments
    NSInteger index = [defaults integerForKey:kDefaultTipIndexKey];
    if(index == -1 || index > [tipValues count]) {
        index = 1;
    }
    
    [self loadSegmentControl:tipSegmentView andSelect:index];
    
    [self updateValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateFromSettings];
}

- (IBAction)onTapOutside:(id)sender {
    //this will close the soft keyboard
    [self.view endEditing:YES];
    
    [self updateValues];
}

- (IBAction)onBillChanged:(id)sender {
    [self updateValues];
}

- (void) updateValues {
    float bill = [self.billInput.text floatValue];
    
    float tipRate = [tipValues[self.tipSegmentView.selectedSegmentIndex] floatValue];
    
    float tipAmount = bill * tipRate;
    float total = bill + tipAmount;
    
    self.tipRateLabel.text = [NSString stringWithFormat:kTipRateFormat, tipRate * 100];
    
    self.tipAmountLabel.text = [NSString stringWithFormat:kTipFormat, tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:kTipFormat, total];
    
    
}

- (void) onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)loadSegmentControl:(UISegmentedControl*) segmentControl andSelect:(NSInteger)index {
    [segmentControl removeAllSegments];
    for (int i=0; i < [tipValues count]; ++i) {
        NSString* title = [NSString stringWithFormat:kTipRateFormat, [tipValues[i] floatValue] * 100];
        [segmentControl insertSegmentWithTitle:title atIndex:i animated:NO];
    }
    
    [segmentControl setSelectedSegmentIndex:index];
}

@end
