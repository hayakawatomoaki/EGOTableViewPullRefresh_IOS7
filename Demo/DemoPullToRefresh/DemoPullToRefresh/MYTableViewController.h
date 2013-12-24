//
//  MYTableViewController.h
//  DemoPullToRefresh
//
//  Created by HAYAKAWA TOMOAKI on 2013/12/19.
//  Copyright (c) 2013年 hayatomo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshHeaderViewIOS7.h"

@interface MYTableViewController : UIViewController<EGORefreshTableHeaderDelegate, UITableViewDelegate,UITableViewDataSource>
{
    EGORefreshHeaderViewIOS7 *_refreshHeaderView;

    UITableView __strong *_tableView;
    NSArray __strong *_keys;
    NSDictionary __strong *dataSource_;
}
@end
