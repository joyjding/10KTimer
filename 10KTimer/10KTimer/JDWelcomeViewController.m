//
//  JDWelcomeViewController.m
//  10KTimer
//
//  Created by Joy Ding on 9/7/13.
//  Copyright (c) 2013 Hackbright. All rights reserved.
//

#import "JDWelcomeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface JDWelcomeViewController ()
@property (strong, nonatomic) IBOutlet UIButton *welcomeStartTiming;
@property (strong, nonatomic) IBOutlet UILabel *welcomeTotalTime;
@property (strong, nonatomic) IBOutlet UIView *welcomeView;
@end

@implementation JDWelcomeViewController

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
    // Do any additional setup after loading the view from its nib.
    
    CGFloat kTotalTime = [[NSUserDefaults standardUserDefaults] floatForKey:@"kTimingSession"];
    NSString *TotalTimeString = [NSString stringWithFormat: @"Great job! So far you've accomplished %f hours out of your 10,000 hour goal. Ready to go again?", kTotalTime];
    self.welcomeTotalTime.text = TotalTimeString;
    [self roundCorners];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Polishing

- (void) roundCorners
{
    self.welcomeView.layer.cornerRadius = 5.0f;
}

#pragma mark - Button Action

- (IBAction) dismissViewController:(id) sender
{
    [self dismissViewControllerAnimated:YES completion:^{ //empty block for completion action
    }];
}

@end
