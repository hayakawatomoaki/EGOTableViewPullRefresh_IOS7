//
//  MYWebViewController.h
//  DemoPullToRefresh
//
//  Created by HAYAKAWA TOMOAKI on 2013/12/19.
//  Copyright (c) 2013年 hayatomo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshHeaderViewIOS7.h"

@interface MYWebViewController : UIViewController<EGORefreshTableHeaderDelegate, UIScrollViewDelegate, UIWebViewDelegate>
{
    EGORefreshHeaderViewIOS7 *_refreshHeaderView;
    UIWebView *_webView;
    UIActivityIndicatorView __strong *ai;
}

@end
