//
//  MYTableViewController.m
//  DemoPullToRefresh
//
//  Created by HAYAKAWA TOMOAKI on 2013/12/19.
//  Copyright (c) 2013年 hayatomo.com. All rights reserved.
//

#import "MYTableViewController.h"

@interface MYTableViewController ()

@end

@implementation MYTableViewController

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // tabBar
    self.title = @"テーブル";
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:1];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    // navigation
    self.navigationItem.title = @"テーブル";

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundView = nil;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    _keys = [[NSArray alloc] initWithObjects:@"", nil];
    NSMutableArray* data = [NSMutableArray array];
    for (int i = 0 ; i < 100 ; i++) {
        NSArray *strArray = [NSArray arrayWithObjects:
                             @"りんごりんごりんごりんご"
                             ,@"ごりらごりらごりら"
                             ,@"らっぱらっぱらっぱらっぱ"
                             ,@"ぱせりぱせりぱせりぱせりぱせり"
                             ,@"いちごいちごいちごいちごいちごいちご"
                             ,@"ご飯ご飯ご飯ご飯ご飯ご飯"
                             , nil];
        int number = arc4random() % [strArray count];
        NSString* _tmp = [strArray objectAtIndex:number];
        [data addObject:_tmp];
    }
    NSArray* objects = [NSArray arrayWithObjects:data, nil];
    dataSource_ = [[NSDictionary alloc] initWithObjects:objects forKeys:_keys];

    // Pull To Refresh
    if (_refreshHeaderView == nil) {
		EGORefreshHeaderViewIOS7 *view = [[EGORefreshHeaderViewIOS7 alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _tableView.bounds.size.height, self.view.frame.size.width, _tableView.bounds.size.height)];
		view.delegate = self;
        [view setScrollViewContentInset];

		[_tableView addSubview:view];
		_refreshHeaderView = view;
	}

}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)pulledRefreshControl
{
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self performSelector:@selector(pulledRefreshControl) withObject:nil afterDelay:0.4]; // TODO afterDelayの調整
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	
    //	return _reloading; // should return if data source model is reloading
	return NO; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}


- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    id key = [_keys objectAtIndex:section];
    return [[dataSource_ objectForKey:key] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"basis-cell"];
    if ( nil == cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"basis-cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = [UIColor colorWithRed:1 green:0.584 blue:0 alpha:.5]; /*#ff9500*/
    } else {
        cell.backgroundColor = [UIColor colorWithRed:1 green:0.369 blue:0.227 alpha:.5]; /*#ff5e3a*/
    }
    id key = [_keys objectAtIndex:indexPath.section];
    NSString* text = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return [_keys count];
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_keys objectAtIndex:section];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
