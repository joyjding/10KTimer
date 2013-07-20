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

@property (strong, nonatomic) NSArray *colorArray;

@property (nonatomic) CGFloat blockStartingX;

@end

@implementation JDViewController


#pragma mark - View Lifecycle Methods

- (void)viewDidLoad //before view loads the first time, do something
{
    [super viewDidLoad];

    [self setupColorArray];
    
    self.blockStartingX = 0.0f;
    
}


- (void) viewWillAppear:(BOOL)animated //happens anytime you go back to the screen
{
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated //once screen is loaded, do this animation
{
    [super viewDidAppear:animated];

    [NSTimer scheduledTimerWithTimeInterval:10.0f
                                     target:self
                                   selector:@selector(createAndAnimateBlock)
                                   userInfo:nil
                                    repeats:YES];
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

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning //gets called if phone freaks out. If this gets called repeatedly, app crashes
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Color Block logic


- (UIView*)createBlock:(UIColor*)color
{
    UIView *block = [[UIView alloc]init]; //nested functions
    block.backgroundColor = color;
    block.frame = CGRectMake(100.0f, 0.0f, 50.0f, 50.0f);
    return block;
}

- (void) createAndAnimateBlock
{
    // TODO: We are going to change this code to select a random color each time
    // and to drop from an increasing-X each time.
    
    CGFloat xStartingPointForBlockAnimation = self.blockStartingX;
    
    UIColor *newBlockColor = [UIColor blueColor];
    UIView* newBlock = [self createBlock:newBlockColor];
    newBlock.frame = CGRectMake(xStartingPointForBlockAnimation, 0.0f, 50.0f, 50.0f);
    [self.view addSubview:newBlock];
    
    
    [UIView animateWithDuration:60.0f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^(){
                         newBlock.frame=CGRectMake(xStartingPointForBlockAnimation, (self.view.frame.size.height-newBlock.frame.size.height), newBlock.frame.size.width, newBlock.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"dropped block");
                     }
     ];
    
}

- (void) setupColorArray
{
    self.colorArray = @[[UIColor blueColor], [UIColor magentaColor], [UIColor greenColor]];
}

@end
