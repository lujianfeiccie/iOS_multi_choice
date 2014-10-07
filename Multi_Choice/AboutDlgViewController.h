//
//  AboutDlgViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-9-8.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface AboutDlgViewController : AbstractViewController<UITableViewDelegate,
UITableViewDataSource,HttpRequestToolDelegate,DialogUtilDelegate>

{
         AppDelegate* app;
    IBOutlet UILabel *m_lbl_version;
    IBOutlet UILabel *m_lbl_copyright;
    IBOutlet UIImageView *m_img_logo;
    IBOutlet UITableView *m_tableview_setting;
    NSMutableArray* m_datalist;
    HttpRequestTool *http;
    DialogUtil *m_dialog;
    NSString *m_trackViewUrl;
}
@end
