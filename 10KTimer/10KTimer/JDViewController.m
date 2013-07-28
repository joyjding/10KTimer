//
//  JDViewController.m
//  10KTimer
//
//  Created by Gemma Barlow and Joy Ding on 7/6/13.
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
}



- (void) viewWillAppear:(BOOL)animated //happens anytime you go back to the screen
{
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated //once screen is loaded, do this animation
{
    [super viewDidAppear:animated];
    
    for (int level = 1; level<9; level++) {
    
        [self createBlockAndAnimate:level];
        [self createBlockAndAnimate:level];
        [self createBlockAndAnimate:level];
        [self createBlockAndAnimate:level];
        [self createBlockAndAnimate:level];
    }    
}

//function that ns timer could call, that would create a block every s seconds, and change level every 5 blocks


- (void) viewWillDisappear:(BOOL)animated //what happens when you navigate away from the view
{
    [super viewWillDisappear:animated];
}

- (void) viewDidUnload // never gets called anymore. so could be deleted!
{
    /// Do something
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning //gets called if phone freaks out. If this gets called repeatedly, app crashes
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Block Position

//- (int)whereBlock
//{
//    
//    
//    
//    for (int i = 0 ; i<1; i++)
//    {
//        int counter;
//        counter = i;
//        
//        [NSTimer scheduledTimerWithTimeInterval:5.0f
//                                         target:self selector:@selector(createBlockAndAnimate:counter)
//                                       userInfo:nil
//                                        repeats:YES]; //How do I pass an argument into this timer object? Using userInfo
//    }
//}

#pragma mark - Create Block Functions

- (UIView*)createBlock:(UIColor*)color
{
    UIView *block = [[UIView alloc]init]; //nested functions
    block.backgroundColor = color;
    return block;
}


- (UIColor*)createRandomColor //generate a random color *color
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}


- (void) createBlockAndAnimate: (int)level
{
    UIColor* color = [self createRandomColor]; //b/c we're calling this method from inside this view controller, use []
    UIView* newBlock =[self createBlock:color];
    
    NSInteger randStart = arc4random_uniform(5); //generate a random start position
    NSInteger randEnd = arc4random_uniform(5); //generate a random end position
    
    //Main view: create this block, doesn't show until added in subview
    newBlock.frame=CGRectMake(kBlockSize*randStart, 0.0f, kBlockSize, kBlockSize);//(x pos, y pos, width, height)
    
    [self.view addSubview:newBlock]; //add block to main view (show block)
    
    //animate the block
    //CGFloat is a primitive type, so it doesn't need a *, because it doesn't need a pointer
    CGFloat newBlockOriginX = randEnd*CGRectGetWidth(newBlock.frame);
    CGFloat newBlockOriginY = CGRectGetHeight(newBlock.superview.bounds)-level*CGRectGetHeight(newBlock.frame);
    
    
    
    [UIView animateWithDuration:10.0f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^()
                                    {
                                        newBlock.frame=CGRectMake(newBlockOriginX, newBlockOriginY, kBlockSize, kBlockSize);
                                    }
                                        completion:^(BOOL finished) {
                         
                         NSLog(@"dropped block"); //@ for any NS object //ask J about this
                         //NSLog(@"dropped block", frameHeight);
                     }
     ];
}
@end





