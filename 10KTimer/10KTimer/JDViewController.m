//
//  JDViewController.m
//  10KTimer
//
//  Created by Gemma Barlow on 7/6/13.
//  Copyright (c) 2013 Hackbright. All rights reserved.
//

#import "JDViewController.h"

@interface JDViewController () //properties go here (things that you want to interact with)
@property (weak, nonatomic) IBOutlet UIImageView *catdog;
@end

@implementation JDViewController


// View lifecycle methods

- (void)viewDidLoad //before view loads the first time, do something
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void) viewWillAppear:(BOOL)animated //happens anytime you go back to the screen
{
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated //once screen is loaded, do this animation
{
    [super viewDidAppear:animated];
    
    //NSLog(@"catdog image is %@", self.catdog);
    //NSLog(@"image height is %f", self.catdog.frame.size.height);
    [UIView animateWithDuration:60.0f
                          delay:0.5f
                         options:UIViewAnimationOptionCurveLinear
                     animations:^(){
                         self.catdog.frame=CGRectMake(0.0f, (self.view.frame.size.height-self.catdog.frame.size.height), self.catdog.frame.size.width, self.catdog.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"dropped block");
                     }
     ];
}




- (void) viewWillDisappear:(BOOL)animated //what happens when you navigate away from the view
{
    [super viewWillDisappear:animated];
}

- (void) viewDidUnload // very last thing you can do (called) on the way out. 
{
    /// Do something
    [super viewDidUnload];
}




- (void)didReceiveMemoryWarning //gets called if phone freaks out. If this gets called repeatedly, app crashes
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
