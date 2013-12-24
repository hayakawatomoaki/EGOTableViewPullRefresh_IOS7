//
//  AppDelegate.m
//  DemoPullToRefresh
//
//  Created by HAYAKAWA TOMOAKI on 2013/12/24.
//  Copyright (c) 2013年 hayatomo.com. All rights reserved.
//

#import "AppDelegate.h"
#import "MYTableViewController.h"
#import "MYWebViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    //
    // set View
    //
    CGRect bounds = [[UIScreen mainScreen] bounds];
    _window = [[UIWindow alloc] initWithFrame:bounds];
    _rootController = [[UITabBarController alloc] init];
    _window.rootViewController = _rootController;
    [_window makeKeyAndVisible];
    
    _myTableViewController = [[UINavigationController alloc] initWithRootViewController:[[MYTableViewController alloc] init]];
    _myWebViewController = [[UINavigationController alloc] initWithRootViewController:[[MYWebViewController alloc] init]];

    NSArray* controllers = [NSArray arrayWithObjects:
                            _myTableViewController,
                            _myWebViewController,
                            nil];
    
    [(UITabBarController*)_rootController setViewControllers:controllers animated:NO];
    [(UITabBarController*)_rootController setSelectedViewController:_myTableViewController];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
