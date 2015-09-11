//
//  ViewController.m
//  TipCalculator
//
//  Created by Cristan Zhang on 9/11/15.
//  Copyright (c) 2015 FastTrack. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billInput;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipSegmentView;
@property (weak, nonatomic) IBOutlet UILabel *tipRateLabel;

@property (nonatomic) NSArray* tipValues;

- (IBAction)onTapOutside:(id)sender;
- (IBAction)onBillChanged:(id)sender;

- (void) updateTipRate;

@end

@implementation TipViewController

@synthesize tipValues;


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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTapOutside:(id)sender {
    //this will close the soft keyboard
    [self.view endEditing:YES];
    
    [self updateTipRate];
}

- (IBAction)onBillChanged:(id)sender {
    [self updateTipRate];
}

- (void) updateTipRate {
    float bill = [self.billInput.text floatValue];
    tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipRate = [tipValues[self.tipSegmentView.selectedSegmentIndex] floatValue];
    
    float tipAmount = bill * tipRate;
    
    self.tipRateLabel.text = [NSString stringWithFormat:@"%2.2f%%", tipRate * 100];
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    
}

@end
