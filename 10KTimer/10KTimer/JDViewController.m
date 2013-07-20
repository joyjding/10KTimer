//
//  JDViewController.m
//  10KTimer
//
//  Created by Gemma Barlow on 7/6/13.
//  Copyright (c) 2013 Hackbright. All rights reserved.
//

#import "JDViewController.h"

@interface JDViewController () //properties go here (things that you want to interact with)
@property (strong, nonatomic) NSArray *colorObjects;
@end

@implementation JDViewController

#define kBlockSize 64.0f



- (void)viewDidLoad //before view loads the first time, do something
{
    [super viewDidLoad];
    
    self.colorObjects = @[[UIColor blueColor], [UIColor redColor], [UIColor yellowColor], [UIColor whiteColor]];
    
    [NSTimer scheduledTimerWithTimeInterval:5.0f
                                     target:self selector:@selector(createBlockAndAnimate)
                                   userInfo:nil
                                    repeats:YES];
}



- (void) viewWillAppear:(BOOL)animated //happens anytime you go back to the screen
{
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated //once screen is loaded, do this animation
{
    [super viewDidAppear:animated];    
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

#pragma mark - Create Block Functions

- (UIView*)createBlock:(UIColor*)color
{
    UIView *block = [[UIView alloc]init]; //nested functions
    block.backgroundColor = color;
    return block;
}

- (void)createBlockAndAnimate
{
    NSInteger randStart = arc4random_uniform(4);
    NSInteger randEnd = arc4random_uniform(4);
    
    NSInteger randInt = arc4random_uniform(self.colorObjects.count);
    UIColor *newBlockColor = self.colorObjects[randInt];
    UIView* newBlock =[self createBlock:newBlockColor]; //UiViewController: create block passing in blue UIColor object. Main view: create this block, doesn't show until added in subview
    newBlock.frame=CGRectMake(kBlockSize*randStart, 0.0f, kBlockSize, kBlockSize);
    [self.view addSubview:newBlock];
    
    [UIView animateWithDuration:30.0f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^(){
                         newBlock.frame=CGRectMake(kBlockSize*randEnd, (self.view.frame.size.height-newBlock.frame.size.height), newBlock.frame.size.width, newBlock.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"dropped block");
                     }
     ];
}



@end










