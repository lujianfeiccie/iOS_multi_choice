//
//  RootViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-8-24.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
#import "ModelData.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) toolBarLeft
{
    [m_dialog_search showDialogWithInputTitle:@"提示" message:@"请输入搜索内容" confirm:@"确定" cancel:@"取消"];
}

-(void) toolBarRight
{
    ViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"about_view"];
    [app.navController pushViewController:next animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    app = [[UIApplication sharedApplication]delegate];
    
    m_dialog_search = [[DialogUtil alloc] init];
    m_dialog_search.delegate = self;
    
    m_tableview_list.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableview_list.backgroundColor = GLOBAL_BGColor;
    self.navigationItem.title = @"财务管理学";
    
    m_datalist = [[NSMutableArray alloc]init];
    ModelData *model = [[ModelData alloc]init];
    model.m_text = @"2014年4月真题";
    model.m_value = @"2014_04";
    [m_datalist addObject:model];
    
    model = [[ModelData alloc]init];
    model.m_text = @"2013年10月真题";
    model.m_value = @"2013_10";
    [m_datalist addObject:model];
    
    model = [[ModelData alloc]init];
    model.m_text = @"2013年1月真题";
    model.m_value = @"2013_01";
    [m_datalist addObject:model];
    
    model = [[ModelData alloc]init];
    model.m_text = @"2012年10月真题";
    model.m_value = @"2012_10";
    [m_datalist addObject:model];
    
    model = [[ModelData alloc]init];
    model.m_text = @"2011年10月真题";
    model.m_value = @"2011_10";
    [m_datalist addObject:model];
    
    model = [[ModelData alloc]init];
    model.m_text = @"2010年10月真题";
    model.m_value = @"2010_10";
    [m_datalist addObject:model];
    
    model = [[ModelData alloc]init];
    model.m_text = @"2009年10月真题";
    model.m_value = @"2009_10";
    [m_datalist addObject:model];
    
    model = [[ModelData alloc]init];
    model.m_text = @"综合真题";
    model.m_value = @"all";
    [m_datalist addObject:model];

    [m_tableview_list setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-self.navigationController.navigationBar.frame.size.height)];

  
    self.navigationItem.leftBarButtonItem = [ButtonUtil createToolBarButton:@"搜索" target:self action:@selector(toolBarLeft)];
    self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"关于" target:self action:@selector(toolBarRight)];
    
    m_tableview_list.delegate = self;
    m_tableview_list.dataSource = self;
     NSLogExt(@"%f %f", [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    
    
    NSLogExt(@"%f %f %f %f",m_tableview_list.frame.origin.x,
             m_tableview_list.frame.origin.y,
             m_tableview_list.frame.size.width,
             m_tableview_list.frame.size.height);
    
//    m_tableview_list.backgroundColor = [UIColor redColor];
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
  //  NSLog(@"viewDidLayoutSubviews");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //  [self MyLog:[NSString stringWithFormat:@"didReceiveMemoryWarning count=%d",[self.datalist count]]];
    return [m_datalist count];
//    return 1;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    cell.tag = 1;
    if (!cell)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    cell.backgroundColor = GLOBAL_BGColor;
//    cell.backgroundColor = [UIColor greenColor];
    NSUInteger row = [indexPath row];
    cell.textLabel.text = ((ModelData*)[m_datalist objectAtIndex:row]).m_text;
    cell.textLabel.font = [UIFont fontWithName:@"" size:19.0f];
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 50.0f;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    
   ViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"question_view"];
   next.m_filename = ((ModelData*)[m_datalist objectAtIndex:row]).m_value;
   next.m_title = ((ModelData*)[m_datalist objectAtIndex:row]).m_text;
   [[app navController] pushViewController:next animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
    
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

/*- (IBAction)btn_FirstClick:(id)sender {
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"question_view"];
    [[app navController] pushViewController:next animated:YES];
}*/

-(void) onDialogConfirmClick : (DialogUtil*) dialog
{
    if (m_dialog_search == dialog)
    {
      //  NSLogExt(@"onConfirm");
    }
}
-(void) onDialogCancelClick : (DialogUtil*) dialog
{
    if (m_dialog_search == dialog)
    {
       // NSLogExt(@"onCancel");
    }
}
-(void) onDialogTextReceive : (DialogUtil*) dialog Text:(NSString *)text
{
    if (m_dialog_search == dialog)
    {
        NSLogExt(@"search text=%@",text);
        if([text isEqualToString:@""])
        {
            DialogUtil *dialog = [[DialogUtil alloc]init];
            [dialog showDialogTitle:@"提示" message:@"输入不能为空!" confirm:@"知道"];
            return;
        }
        NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadSearch:) object:text];
        [myThread start];
    }
}
-(void) threadSearch :(NSString*) keywords
{
    
    XMLHelper* xmlHelper2014_04 = [[XMLHelper alloc]init];
    
    [xmlHelper2014_04 load:@"2014_04"];

    NSMutableArray* questions = [[xmlHelper2014_04 rootElement] m_subElements];
    NSMutableArray* results = [[NSMutableArray alloc]init];
    for (XMLElement* question in questions)
    {
        if ([question.m_title containsString:keywords])
        {
            NSLogExt(@"keywords=%@ title=%@",keywords,question.m_title);
        }
    }
}
- (void)dealloc {
    [m_tableview_list release];
    [m_datalist removeAllObjects];
    [m_datalist release];
    [super dealloc];
}
@end
