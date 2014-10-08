//
//  AppDelegate.m
//  Multi_Choice
//
//  Created by Apple on 14-8-22.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   // NSLog(@"didFinishLaunchingWithOptions");
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    //[self MyLog:[NSString stringWithFormat:@"%f",[[[UIDevice currentDevice] systemVersion] floatValue]]];
    
    RootViewController *rootView =  [storyBoard instantiateViewControllerWithIdentifier:@"rootview"];
    self.navController = [[UINavigationController alloc] init];
    [self.navController pushViewController:rootView animated:YES];
    [self.navController setToolbarHidden:YES];//底部隐藏
    
    [self.window addSubview:self.navController.view];
    [self.window makeKeyAndVisible];
    
   
    m_versionCheckTool = [[VersionCheckTool alloc]init];
    m_versionCheckTool.m_app_id = GLOBAL_APP_ID;
    m_versionCheckTool.m_isAboutDlg = NO;
    NSLogExt(@"m_isAboutDlg=%i",m_versionCheckTool.m_isAboutDlg);
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   // NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   // NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  //  NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     //NSLog(@"applicationDidBecomeActive");
    //Check the version
    [m_versionCheckTool request];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     //NSLog(@"applicationWillTerminate");
}
- (void)dealloc {
    [m_versionCheckTool releaseExt];
    [super dealloc];
}

@end
