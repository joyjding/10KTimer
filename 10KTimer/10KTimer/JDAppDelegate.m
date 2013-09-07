//
//  JDAppDelegate.m
//  10KTimer
//
//  Created by Gemma Barlow on 7/6/13.
//  Copyright (c) 2013 Hackbright. All rights reserved.
//

#import "JDAppDelegate.h"

#import "JDViewController.h"
#import "JDWelcomeViewController.h"

@implementation JDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.viewController = [[JDViewController alloc] initWithNibName:@"JDViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    
    [self.window makeKeyAndVisible];
    JDWelcomeViewController *welcomeView = [[JDWelcomeViewController alloc] initWithNibName:@"JDWelcomeViewController" bundle:nil];
    //welcomeView.modalStyle #here's where you would set presentation/dismissal animation style
    [self.window.rootViewController presentViewController: welcomeView animated:NO completion:nil];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
