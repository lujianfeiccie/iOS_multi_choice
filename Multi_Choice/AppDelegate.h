//
//  AppDelegate.h
//  Multi_Choice
//
//  Created by Apple on 14-8-22.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractViewController.h"
#import "ButtonUtil.h"
#import "PlatformUtil.h"
#import "NSLogExt.h"
#import "Util.h"
#import "HttpRequestTool.h"
#import "SVProgressHUD.h"
#import "DialogUtil.h"
#import "UserInfoTool.h"
#import "VersionCheckTool.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
     UIStoryboard *storyBoard;
    
    VersionCheckTool *m_versionCheckTool;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;

@end
