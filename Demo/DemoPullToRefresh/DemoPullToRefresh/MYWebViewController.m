//
//  MYWebViewController.m
//  DemoPullToRefresh
//
//  Created by HAYAKAWA TOMOAKI on 2013/12/19.
//  Copyright (c) 2013年 hayatomo.com. All rights reserved.
//

#import "MYWebViewController.h"

@interface MYWebViewController ()

@end

@implementation MYWebViewController

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // tabBar
    self.title = @"ウェブ";
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:2];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // navigation
    self.navigationItem.title = @"ウェブ";

    // UIWebview
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    _webView.frame = self.view.bounds;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];

    // Indicator
    ai = [[UIActivityIndicatorView alloc] init];
    ai.frame = CGRectMake(0, 0, 50, 50);
    ai.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    ai.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    ai.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:ai];
    [ai startAnimating];

    // Pull To Refresh
    if (_refreshHeaderView == nil) {
        UIScrollView *webScroller = _webView.scrollView;
        [webScroller setDelegate:self];
        EGORefreshHeaderViewIOS7 *view = [[EGORefreshHeaderViewIOS7 alloc]
                                        initWithFrame:CGRectMake(0.0f,
                                                                 0.0f - webScroller.bounds.size.height,
                                                                 self.view.frame.size.width,
                                                                 webScroller.bounds.size.height)];
        view.delegate = self;
        [view setScrollViewContentInset];
        [webScroller addSubview:view];
        _refreshHeaderView = view;
    }
    
    [self _reload];
}

- (void)_reload
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://yahoo.co.jp/"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [_webView loadRequest:request];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self startIndicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self stopIndicator];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self stopIndicator];
}

- (void) startIndicator
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void) stopIndicator
{
    [ai stopAnimating];
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_webView.scrollView];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self performSelector:@selector(_reload) withObject:nil afterDelay:0.0]; // TODO afterDelayの調整
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	
    //	return _reloading; // should return if data source model is reloading
    //	return _isLoading; // should return if data source model is reloading
    return NO; // TODO
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
