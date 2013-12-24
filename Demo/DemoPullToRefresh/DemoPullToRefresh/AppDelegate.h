//
//  AppDelegate.h
//  DemoPullToRefresh
//
//  Created by HAYAKAWA TOMOAKI on 2013/12/24.
//  Copyright (c) 2013年 hayatomo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *rootController;
@property (strong, nonatomic) UIViewController *myTableViewController;
@property (strong, nonatomic) UIViewController *myWebViewController;

@end
