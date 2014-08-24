//
//  ViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-8-22.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "NSLogExt.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    app = [[UIApplication sharedApplication]delegate];
    
    
    m_xmlHelper = [[XMLHelper alloc]init];
    m_xmlHelper.m_random = YES;
    [m_xmlHelper load];
    
    m_currentIndex = 0;
    
    m_questions = [[m_xmlHelper rootElement] m_subElements];
    m_count = [m_questions count];

    
    m_lbl_choice1 = [[UILabelExt alloc]init];
    m_lbl_choice2 = [[UILabelExt alloc]init];
    
    m_lbl_choice1.m_prefix = @"A.";
    m_lbl_choice2.m_prefix = @"B.";
    m_lbl_choice3.m_prefix = @"C.";
    m_lbl_choice4.m_prefix = @"D.";
    [m_lbl_choice1 setFrame:CGRectMake(m_lbl_title.frame.origin.x,
                                       m_lbl_title.frame.origin.y+50,
                                       m_lbl_title.frame.size.width,
                                       m_lbl_title.frame.size.height)];

    [m_lbl_choice2 setFrame:CGRectMake(m_lbl_title.frame.origin.x,
                                       m_lbl_choice1.frame.origin.y+50,
                                       m_lbl_title.frame.size.width,
                                       m_lbl_title.frame.size.height)];

    [m_lbl_choice3 setFrame:CGRectMake(m_lbl_title.frame.origin.x,
                                       m_lbl_choice2.frame.origin.y+50,
                                       m_lbl_title.frame.size.width,
                                       m_lbl_title.frame.size.height)];

    [m_lbl_choice4 setFrame:CGRectMake(m_lbl_title.frame.origin.x,
                                       m_lbl_choice3.frame.origin.y+50,
                                       m_lbl_title.frame.size.width,
                                       m_lbl_title.frame.size.height)];

   
    
    m_lbl_choice1.userInteractionEnabled = YES;
    m_lbl_choice2.userInteractionEnabled = YES;
    m_lbl_choice3.userInteractionEnabled = YES;
    m_lbl_choice4.userInteractionEnabled = YES;
    
    m_lbl_choice1.delegateExt = self;
    m_lbl_choice2.delegateExt = self;
    m_lbl_choice3.delegateExt = self;
    m_lbl_choice4.delegateExt = self;
    
    [self.view addSubview:m_lbl_choice1];
    [self.view addSubview:m_lbl_choice2];
    [self.view addSubview:m_lbl_choice3];
    [self.view addSubview:m_lbl_choice4];
    
    [self updateQuestionView];
    
 //   NSLogExt(@"text=%@",[m_lbl_choice1 getText]);
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

-(void) onLabelExtClick:(id)sender
{
    if ([sender isEqual:m_lbl_choice1]) {
        NSLogExt(@"choice1");
        [[m_questions objectAtIndex:m_currentIndex]setSelectExt:0];
        if ([[m_lbl_choice1 getTextExt] isEqualToString:m_str_answer])
        {
            [m_lbl_choice1 setRight];
        }
        else
        {
            [m_lbl_choice1 setWrong];
        }
    }
    else if ([sender isEqual:m_lbl_choice2]) {
        NSLogExt(@"choice2");
        [[m_questions objectAtIndex:m_currentIndex]setSelectExt:1];
        if ([[m_lbl_choice2 getTextExt] isEqualToString:m_str_answer])
        {
            [m_lbl_choice2 setRight];
        }
        else
        {
            [m_lbl_choice2 setWrong];
        }
    }
    else if ([sender isEqual:m_lbl_choice3]) {
        NSLogExt(@"choice3");
        [[m_questions objectAtIndex:m_currentIndex]setSelectExt:2];
        if ([[m_lbl_choice3 getTextExt] isEqualToString:m_str_answer])
        {
            [m_lbl_choice3 setRight];
        }
        else
        {
            [m_lbl_choice3 setWrong];
        }
    }
    else if ([sender isEqual:m_lbl_choice4]) {
        NSLogExt(@"choice4");
        [[m_questions objectAtIndex:m_currentIndex]setSelectExt:3];
        if ([[m_lbl_choice4 getTextExt] isEqualToString:m_str_answer])
        {
            [m_lbl_choice4 setRight];
        }
        else
        {
            [m_lbl_choice4 setWrong];
        }
    }

    if ([[m_lbl_choice1 getTextExt]isEqualToString:m_str_answer]) {
        [m_lbl_choice1 setRight];
    }
    else if ([[m_lbl_choice2 getTextExt]isEqualToString:m_str_answer]) {
            [m_lbl_choice2 setRight];
    }
    else if ([[m_lbl_choice3 getTextExt]isEqualToString:m_str_answer]) {
        [m_lbl_choice3 setRight];
    }
    else if ([[m_lbl_choice4 getTextExt]isEqualToString:m_str_answer]) {
        [m_lbl_choice4 setRight];
    }
}
- (void) updateQuestionView{
    m_lbl_title.text = [[m_questions objectAtIndex:m_currentIndex] m_title];
    NSArray *choices = [[m_questions objectAtIndex:m_currentIndex] m_subElements];
    m_str_answer = [[m_questions objectAtIndex:m_currentIndex] m_answer];
    NSInteger selected =[[m_questions objectAtIndex:m_currentIndex] m_selected];
    for (NSInteger i=0; i<[choices count]; ++i) {
       
        if (i==0) {
            [m_lbl_choice1 setTextExt:[[choices objectAtIndex:i] m_choice]];
        }
        else if (i==1) {
            [m_lbl_choice2 setTextExt:[[choices objectAtIndex:i] m_choice]];
        }
        else if (i==2) {
            [m_lbl_choice3 setTextExt:[[choices objectAtIndex:i] m_choice]];
        }
        else if (i==3) {
            [m_lbl_choice4 setTextExt:[[choices objectAtIndex:i] m_choice]];
        }
        
       
    }
    [m_lbl_choice1 setNormal];
    [m_lbl_choice2 setNormal];
    [m_lbl_choice3 setNormal];
    [m_lbl_choice4 setNormal];
    if (selected==-1) {
      
    }else if(selected==0){
        [self onLabelExtClick: m_lbl_choice1];
    }else if(selected==1){
        [self onLabelExtClick: m_lbl_choice2];
    }else if(selected==2){
        [self onLabelExtClick: m_lbl_choice3];
    }else if(selected==3){
        [self onLabelExtClick: m_lbl_choice4];
    }

}
@end
