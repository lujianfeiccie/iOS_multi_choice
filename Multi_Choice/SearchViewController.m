//
//  SearchViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "SearchViewController.h"
#import "XMLElement.h"
@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize m_array_list;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_tableview = [[UITableView alloc]init];
    [self.view addSubview:m_tableview];
    [m_tableview setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    m_tableview.dataSource = self;
    m_tableview.delegate = self;
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
    cell.backgroundColor = GLOBAL_BGColor;
    cell.textLabel.text = ((XMLElement*)[questions objectAtIndex:row]).m_title;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 2;
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

@end
