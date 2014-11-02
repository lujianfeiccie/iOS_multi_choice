//
//  SearchViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "SearchViewController.h"
#import "XMLElement.h"
#import "MultChoiceDetailViewController.h"
#import "CalcDetailViewController.h"
@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize m_array_list;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationItem.title = @"搜索结果";
    
    m_tableview = [[UITableView alloc]init];
    [self.view addSubview:m_tableview];
    [m_tableview setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    m_tableview.dataSource = self;
    m_tableview.delegate = self;
     app = [[UIApplication sharedApplication]delegate];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [m_array_list count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *questions = [m_array_list objectAtIndex:section];
    return [questions count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    
    NSMutableArray* questions = [m_array_list objectAtIndex:section];
    
    
    static NSString *GroupedTableIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             GroupedTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:GroupedTableIdentifier];
    }
    switch (section) {
        case 0:
        {
         cell.textLabel.text = ((XMLElement*)[questions objectAtIndex:row]).m_title;
                cell.textLabel.numberOfLines = 2;
        }
            break;
        case 1:
        {
            XMLCalcElement* obj =[questions objectAtIndex:row];
            NSUInteger count_items = [obj.m_subElements count];
            NSString* titleForQuestion = @"";
            for (NSUInteger j=0; j<count_items; j++)  //num of items in each question
            {
                XMLCalcElement* item = [obj.m_subElements objectAtIndex:j];
                if ([item.m_tag isEqualToString:@"question"])
                {
                   titleForQuestion = [titleForQuestion stringByAppendingString:item.m_value];
                }
            }

            cell.textLabel.text = titleForQuestion;
            cell.textLabel.numberOfLines = 5;
        }
            break;
        default:
            break;
    }


    cell.backgroundColor = GLOBAL_BGColor;
   
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title=@"";
    switch (section) {
        case 0:
            title=@"选择题";
            break;
        case 1:
            title=@"简答题";
            break;
        case 2:
            title=@"计算题";
            break;
        default:
            break;
    }
    return title;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 80.0f;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSMutableArray* questions= [m_array_list objectAtIndex:section];
    
    switch (section) {
        case 0:
        {
            //Multi Choice
           //NSString* title = [[questions objectAtIndex:row] m_title];
           // NSString* answer= [[questions objectAtIndex:row] m_answer];
        MultChoiceDetailViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"multi_choice_detail"];

            next.m_array_detail = questions;
            next.m_currentIndex = row;
            next.m_title = @"选择题搜索结果";
            [app.navController pushViewController:next animated:YES];
        }
            break;
        case 1:
        {
            CalcDetailViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"calc_detail_view"];
            
            next.m_array_detail = questions;
            next.m_currentIndex = row;
            next.m_title = @"简答题搜索结果";
            [app.navController pushViewController:next animated:YES];

        }
            break;
        default:
            break;
    }
    NSLogExt(@"section=%i\trow=%i",section,row);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [m_tableview release];
    [m_array_list removeAllObjects];
    [m_array_list release];
    [super dealloc];
}
@end
