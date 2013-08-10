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
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSDate *currentTimerStart;
@property (nonatomic) NSTimeInterval timeElapsed;
@end

@implementation JDViewController

#define kBlockSize 64.0f
#define kLevels 8
#define kNumberOfBlocks 5



- (void)viewDidLoad //before view loads the first time, do something
{
    [super viewDidLoad];
    self.timeElapsed = 0.0f;
}

- (void) viewWillAppear:(BOOL)animated //happens anytime you go back to the screen
{
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated //once screen is loaded, do this animation
{
    [super viewDidAppear:animated];

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

- (UIView*)createColorBlock:(UIColor*)color
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

    NSMutableArray *randomXPositions = [NSMutableArray array]; //array creates an empy array
    for (int i = 0;i<kNumberOfBlocks; i++ ) {
        NSInteger index = arc4random_uniform([endXPositionsMutable count]-1); //changed this from a static number:4, to the length of endXPositionsMutable -1
        [randomXPositions addObject:endXPositionsMutable[index]];
        [endXPositionsMutable removeObjectAtIndex:index];
    }
    return randomXPositions;
}

- (void) createBlockAndAnimate: (int) level endX:(int)endX //two parameters
{
    
    UIColor* color = [self createRandomColor]; //b/c we're calling this method from inside this view controller, use []
    UIView* newBlock =[self createColorBlock: color]; //UIColor here is a function call that makes a new UIColor object
    
    NSInteger randStart = arc4random_uniform(kNumberOfBlocks); //generate a random start position
    
    //Main view: create this block, doesn't show until added in subview
    newBlock.frame=CGRectMake(kBlockSize*randStart, 0.0f, kBlockSize, kBlockSize);//(x pos, y pos, width, height)
    newBlock.alpha = 0.0f;
    
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
                                        newBlock.alpha = 1.0f; //changes transparency of block as it falls down
                                    }
                                        completion:^(BOOL finished) {
                     }
     ];
}


- (void) startBlocks
{
    for (int level = 0; level<kLevels; level++) {
        NSMutableArray* xList =[self createRandomXPositions];
        for (int blockNumber = 0; blockNumber<kNumberOfBlocks; blockNumber++) {
            int endXValue = [(NSNumber*)xList[blockNumber] integerValue]; //the () performs a cast. It's not a function call, just type indication
            [self createBlockAndAnimate:level endX:endXValue];
        }
    }
}

- (void) startTimer
{
    self.currentTimerStart = [NSDate date];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:nil selector:nil userInfo:nil repeats:NO];
    NSLog(@"fireDate is %@. currentTimerStart is %@", [self.timer fireDate], self.currentTimerStart);

    for (int level = 0; level<kLevels; level++) {
        NSMutableArray* xList =[self createRandomXPositions];
        for (int blockNumber = 0; blockNumber<kNumberOfBlocks; blockNumber++) {
            int endXValue = [(NSNumber*)xList[blockNumber] integerValue]; //the () performs a cast. It's not a function call, just type indication
            [self createBlockAndAnimate:level endX:endXValue];
        }
    }
}

-(void) stopTimer
{
    NSLog(@"Timer started at: %@ ", self.currentTimerStart);
    [self.timer invalidate];
    NSLog(@"End time: %@", [NSDate date]);
    NSTimeInterval timeToAdd = [[NSDate date] timeIntervalSinceDate:self.currentTimerStart];
    self.timeElapsed += timeToAdd;
    NSLog(@"Time elapsed %lf ", self.timeElapsed);
}

- (IBAction) switchAction:(id) onOff //technically a void function, but putting in IBAction to talk to Interface Builder
{ 
    UISwitch *switchControl = (UISwitch*) onOff;
    if (switchControl.on)
    {
        [self startTimer];
    }
    else
    {
        [self stopTimer];
    }

}
@end





