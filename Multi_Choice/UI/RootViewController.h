//
//  RootViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-8-24.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface RootViewController : UIViewController<UITableViewDelegate,
UITableViewDataSource>

{
    AppDelegate* app;
    __weak IBOutlet UITableView *m_tableview_list;
    NSMutableArray* m_datalist;
}


@end
