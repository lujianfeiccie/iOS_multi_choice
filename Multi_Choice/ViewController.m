//
//  ViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-8-22.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    m_xmlHelper = [[XMLHelper alloc]init];
    m_xmlHelper.m_random = YES;
    [m_xmlHelper load];
    
    m_currentIndex = 0;
    
    m_questions = [[m_xmlHelper rootElement] m_subElements];
    m_count = [m_questions count];

    [self updateQuestionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnNextClick:(id)sender {
    if (m_currentIndex < m_count-1) {
        ++m_currentIndex;
        [self updateQuestionView];
    }
    
}

- (IBAction)btnPrevClick:(id)sender {
    if (m_currentIndex > 0) {
        --m_currentIndex;
        [self updateQuestionView];
    }
}

- (void) updateQuestionView{
    m_lbl_title.text = [[m_questions objectAtIndex:m_currentIndex] m_title];
    NSArray *choices = [[m_questions objectAtIndex:m_currentIndex] m_subElements];
    for (NSInteger i=0; i<[choices count]; ++i) {
        
        if (i==0) {
            m_lbl_choice1.text = [[choices objectAtIndex:i] m_choice];
        }
        else if (i==1) {
            m_lbl_choice2.text = [[choices objectAtIndex:i] m_choice];
        }
    }

}
@end
