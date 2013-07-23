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
    
    [self createBlockAndAnimate:5];
}




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
//                                        repeats:YES];
//    }
//}

#pragma mark - Create Block Functions

- (UIView*)createBlock:(UIColor*)color
{
    UIView *block = [[UIView alloc]init]; //nested functions
    block.backgroundColor = color;
    return block;
}

- (void) createBlockAndAnimate: (int)level
    {
        
        NSInteger randStart = arc4random_uniform(5); //generate a random start position
        NSInteger randEnd = arc4random_uniform(5); //generate a random end position
        
        //generate a random color *color
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        
        //create block of color *color
        UIView* newBlock =[self createBlock:color]; //Main view: create this block, doesn't show until added in subview
        newBlock.frame=CGRectMake(kBlockSize*randStart, 0.0f, kBlockSize, kBlockSize);//(x pos, y pos, width, height)
        
        [self.view addSubview:newBlock]; //add block to main view (show block)
        
        //animate the block
        [UIView animateWithDuration:10.0f
                              delay:0.5f
                            options:UIViewAnimationOptionCurveLinear
                         animations:^(){
                                newBlock.frame=CGRectMake(randEnd*CGRectGetWidth(newBlock.frame), CGRectGetHeight(newBlock.superview.bounds)-level*CGRectGetHeight(newBlock.frame), 64.0f, 64.0f); //QUESTION: Why does this slip off the screen?
                        
                                                       
                                                       //kBlockSize*randEnd, (self.view.frame.size.height-(level*kBlockSize)), newBlock.frame.size.width, newBlock.frame.size.height); //weird off by a lot error going on here
                         }
                         completion:^(BOOL finished) {
                             //NSString frameHeight= self.frame.size.height;
                             //NSLog(frameHeight);
                             newBlock.bounds = newBlock.bounds;
                             NSLog(@"dropped block %@", NSStringFromCGRect(newBlock.bounds)); //@ for any NS object
                             //NSLog(@"dropped block", frameHeight);
                         }
         
         ];
        }
@end





