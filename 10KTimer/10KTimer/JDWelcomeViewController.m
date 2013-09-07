//
//  JDWelcomeViewController.m
//  10KTimer
//
//  Created by Joy Ding on 9/7/13.
//  Copyright (c) 2013 Hackbright. All rights reserved.
//

#import "JDWelcomeViewController.h"

@interface JDWelcomeViewController ()
@property (strong, nonatomic) IBOutlet UIButton *welcomeStartTiming;
@property (strong, nonatomic) IBOutlet UILabel *welcomeTotalTime;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action

- (IBAction) dismissViewController:(id) sender
{
    [self dismissViewControllerAnimated:YES completion:^{ //empty block for completion action
    }];
}

@end
