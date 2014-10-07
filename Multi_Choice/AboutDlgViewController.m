//
//  AboutDlgViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-9-8.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "AboutDlgViewController.h"
#import "PlatformUtil.h"
@interface AboutDlgViewController ()

@end

@implementation AboutDlgViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"关于";
    
    m_tableview_setting.delegate = self;
    m_tableview_setting.dataSource = self;
    
     NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    
    NSString *appname =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    
   

    
    m_lbl_version.text = [NSString stringWithFormat:@"%@ %@",appname,version];
    
    m_datalist = [[NSMutableArray alloc]init];
    
    [m_datalist addObject:@"意见反馈"];
    [m_datalist addObject:@"版本更新"];
    
   // m_tableview_setting.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableview_setting.bounces = false;
   
     app = [[UIApplication sharedApplication]delegate];
    m_dialog = [[DialogUtil alloc]init];
    m_dialog.delegate = self;
    http = [[HttpRequestTool alloc]init];
    http.delegate = self;
}
- (void)viewDidLayoutSubviews
{
    [PlatformUtil ResizeUIToTop:m_img_logo parentView:self.view offSetY:20];
    
    [m_lbl_version setFrame:CGRectMake(0,
                                       m_img_logo.frame.origin.y + m_img_logo.frame.size.height
                                       ,
                                       self.view.frame.size.width,
                                       m_lbl_version.frame.size.height)];
    
    [m_lbl_version setTextAlignment:NSTextAlignmentCenter];

    
    GLfloat m_margin = 10;
    [m_tableview_setting setFrame:CGRectMake(m_margin, m_lbl_version.frame.origin.y+m_lbl_version.frame.size.height+10, self.view.frame.size.width-m_margin*2, [m_datalist count]*40)];
    
    [PlatformUtil ResizeUIToBottom:m_lbl_copyright parentView:self.view offSetY:-10];
    
    [m_tableview_setting deselectRowAtIndexPath:[m_tableview_setting indexPathForSelectedRow] animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [m_datalist count];

}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
   
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [m_datalist objectAtIndex:row];
    return cell;
}
-(GLfloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLfloat height = 40;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    switch (row) {
        case 0:
        {
            //Go to feedback
            UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"feedback_view"];
            [[app navController] pushViewController:next animated:YES];
        }
            break;
        case 1:
        {
           //Go to check the latest version
            [SVProgressHUD showWithStatus:@"正在检查最新版本"];
            http.url = @"http://itunes.apple.com/lookup";
            [http.data removeAllObjects];
            [http.data setObject:[NSString stringWithFormat:@"%i",GLOBAL_APP_ID] forKey:@"id"];
            NSThread* myThread = [[NSThread alloc] initWithTarget:http selector:@selector(startGetRequest) object:nil];
            [myThread start];
        }
            break;
        default:
            break;
    }
}
-(void) onMsgReceive :(NSData*) msg :(NSInteger) errorCode :(NSInteger) statusCode :(HttpRequestTool*) httpRequestTool;
{
    [SVProgressHUD dismiss];
    
    NSError *parse_error=Nil;
    
    NSLogExt(@"error code = %i statusCode = %i",errorCode,statusCode);
    switch (errorCode) {
        case NSURLErrorNotConnectedToInternet://网络断开
            [SVProgressHUD showErrorWithStatus:@"无法连接到网络!"];
            return;
        case NSURLErrorTimedOut://请求超时
            [SVProgressHUD showErrorWithStatus:@"请求超时!"];
            return;
        default:
            break;
    }
    
    
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:msg options:NSJSONReadingMutableLeaves error:&parse_error];
    
    
    switch (statusCode) {
        case 200:
        {
            NSDictionary *results =[dataDic objectForKey:@"results"];
            
            NSString *latestVersion = @"";
            NSString *trackViewUrl = @"";
            NSString *trackName = @"";
            for (NSDictionary* result in results){
                latestVersion =[result objectForKey:@"version"];
                trackViewUrl =[result objectForKey:@"trackViewUrl"];
                trackName =[result objectForKey:@"trackName"];
            }
           
            NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
            
            NSLogExt(@"\nlatestVersion=%@\ntrackViewUrl=%@\ntrackName=%@\ncurrentVersion=%@",
                     latestVersion,trackViewUrl,trackName,currentVersion);
         
          
            if ([currentVersion isEqualToString:latestVersion])
            {
                [SVProgressHUD showSuccessWithStatus:@"已经是最新版本!"];
               
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    m_trackViewUrl = [[trackViewUrl stringByReplacingOccurrencesOfString:@"https://" withString:@"itms-apps://"] copy];
 //NSLog(@" %@",m_trackViewUrl);
                    // 更新UI
                    [m_dialog showDialogTitle:@"提示"
                                      message: [NSString stringWithFormat:@"最新版本%@,现在去下载?",latestVersion] confirm:@"是的"
                                       cancel:@"以后再说"];
                });
            }
            //NSLogExt(@"status=%@",status);
        }
            break;
            
        default:
            break;
    }

}
#pragma marks -- DialogUtilDelegate --
-(void) onDialogConfirmClick : (DialogUtil*) dialog
{
    if (dialog == m_dialog) {
        if(m_trackViewUrl!=nil){
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:m_trackViewUrl]];
        }
    }
}
-(void) onDialogCancelClick : (DialogUtil*) dialog
{
    if (dialog == m_dialog) {
        
    }
}

- (void)dealloc {
    [m_lbl_version release];
    [m_lbl_copyright release];
    [m_img_logo release];
    [m_tableview_setting release];
    [http.data removeAllObjects];
    [http.data release];
    [http release];
    [m_dialog release];
    [m_trackViewUrl release];
    [super dealloc];
}
@end
