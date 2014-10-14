//
//  CalcViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-10-14.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "CalcViewController.h"

@interface CalcViewController ()

@end

@implementation CalcViewController
@synthesize m_title;
@synthesize m_filename;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    app = [[UIApplication sharedApplication]delegate];
    
    self.navigationItem.title = m_title;
    
    m_xmlHelper = [[XMLCalcHelper alloc]init];
    
    [m_xmlHelper load:m_filename];

    m_questions = [[m_xmlHelper rootElement] m_subElements];
    
    NSUInteger count = [m_questions count];
    for (NSUInteger i=0; i<count; i++) {
        XMLCalcElement* obj =[m_questions objectAtIndex:i];
        NSLogExt(@"Question text=%@ image=%@",obj.m_question,obj.m_image_question);
        
        XMLCalcElement *obj_answer = [[obj m_subElements] objectAtIndex:0];
        NSLogExt(@"Answer text=%@ image=%@",obj_answer.m_answer,obj_answer.m_image_answer);
    }
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
