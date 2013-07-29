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
        NSMutableArray* xList =[self createRandomXPositions];
        NSLog(@"xList array is %@", xList);
        for (int blockNumber = 0; blockNumber<5; blockNumber++) {
            int endXValue = [(NSNumber*)xList[blockNumber] integerValue]; //the () performs a cast. It's not a function call, just type indication
            [self createBlockAndAnimate:level endX:endXValue];
        }
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

- (NSMutableArray*) createRandomXPositions
{
    NSArray* endXPositions = @[@0,@1,@2,@3,@4];//make an array each time we move levels //@ makes it an NSinteger which can be a float or an integer. Apparently arrays don't take numbers in objective c????
    NSMutableArray *endXPositionsMutable = [NSMutableArray arrayWithArray:endXPositions];//super strange conversion to NSMutableArray
    
    NSLog(@"endXPositionsMutable %@ ", endXPositionsMutable);
    NSMutableArray *randomXPositions = [NSMutableArray array]; //array creates an empy array
    for (int i = 0;i<5; i++ ) {
        NSInteger index = arc4random_uniform([endXPositionsMutable count]-1); //changed this from a static number:4, to the length of endXPositionsMutable -1
        [randomXPositions addObject:endXPositionsMutable[index]];
        [endXPositionsMutable removeObjectAtIndex:index];
        NSLog(@"endXPositionsMutable %@ ", endXPositionsMutable);
    }
    return randomXPositions; //convert NSMutableArray to array?
}

- (void) createBlockAndAnimate: (int) level endX:(int)endX //two parameters
{
    UIColor* color = [self createRandomColor]; //b/c we're calling this method from inside this view controller, use []
    UIView* newBlock =[self createBlock: color]; //UIColor here is a function call that makes a new UIColor object
    
    NSInteger randStart = arc4random_uniform(5); //generate a random start position
    
    //Main view: create this block, doesn't show until added in subview
    newBlock.frame=CGRectMake(kBlockSize*randStart, 0.0f, kBlockSize, kBlockSize);//(x pos, y pos, width, height)
    
    [self.view addSubview:newBlock]; //add block to main view (show block)
    
    //animate the block
    //CGFloat is a primitive type, so it doesn't need a *, because it doesn't need a pointer
    CGFloat newBlockOriginX = endX*CGRectGetWidth(newBlock.frame);
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





