//
//  AlertViewAppDelegate.m
//  AlertView
//
//  Created by Lap on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlertViewAppDelegate.h"
#import "BBAlertView.h"


@implementation AlertViewAppDelegate


@synthesize window=_window;

UIButton *btn;
UIButton *btn2;

#pragma mark-
#pragma mark Alert View
-(void)bbAlertView:(id)sender{
    
    if(sender == btn)
    {
        BBAlertView *_alertView = [[BBAlertView alloc] initWithTitle:@"Alert View 1" message:@"this is message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        _alertView.fillColor = [UIColor blackColor];
        _alertView.strokeColor = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8];
        
        [_alertView show];
        [_alertView release];
    
    }else if(sender == btn2)
    {
        BBAlertView *_alertView = [[BBAlertView alloc] initWithTitle:@"Alert View 2" message:@"this is message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        _alertView.fillColor = [UIColor purpleColor];
        _alertView.strokeColor = [UIColor colorWithHue:6.225 saturation:6.4 brightness:0.6 alpha:0.8];
        
        [_alertView show];
        [_alertView release];
    
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    ///////////////////////////////////////
    // Button style 1 in window
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"Alert View" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 100, 40)];
    [btn addTarget:self action:@selector(bbAlertView:) forControlEvents:UIControlEventTouchUpInside];
    btn.center = CGPointMake(160, 240);
    
    ///////////////////////////////////////
    // Button style 2 in window
    btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setTitle:@"Alert View" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 0, 100, 40)];
    [btn2 addTarget:self action:@selector(bbAlertView:) forControlEvents:UIControlEventTouchUpInside];
    btn2.center = CGPointMake(160, 350);
    
    
    [self.window addSubview:btn];
    [self.window addSubview:btn2];
    
    
    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
