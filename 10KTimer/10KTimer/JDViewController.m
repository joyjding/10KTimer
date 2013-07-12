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
//	//UIImageView *pinkblock = [[UIImageView alloc]init];
//    //pinkblock.image=[UIImage imageNamed:<#(NSString *)#>]
//    UIView *pinkblock = [[UIView alloc]init]; //nested functions
//    pinkblock.backgroundColor = [UIColor magentaColor];
//    pinkblock.frame=CGRectMake(100.0f, 0.0f, 50.0f, 50.0f);
//    
//    [self.view addSubview:pinkblock]; //perform the method addSubview on self.view, with arg()
    
    //[self createBlock:[UIColor blueColor]];
    
    //[self [createBlock:blue]]; //call createBlock
    
    UIColor *newBlockColor = [UIColor blueColor]; //obj of type UIColor is blue UIColor object
    UIView* newBlock =[self createBlock:newBlockColor]; //UiViewController: create block passing in blue UIColor object
    [self.view addSubview:newBlock];
}

- (UIView*)createBlock:(UIColor*)color
{
    UIView *block = [[UIView alloc]init]; //nested functions
    block.backgroundColor = color;
    block.frame=CGRectMake(100.0f, 0.0f, 50.0f, 50.0f);
    return block;
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
