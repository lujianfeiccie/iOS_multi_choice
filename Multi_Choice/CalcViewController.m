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
    m_isShowingAnswer = NO;

    // Do any additional setup after loading the view.
    
    
    
    app = [[UIApplication sharedApplication]delegate];

    
    self.navigationItem.title = m_title;
    
    m_xmlHelper = [[XMLCalcHelper alloc]init];
    
    [m_xmlHelper load:m_filename];

    m_questions = [[m_xmlHelper rootElement] m_subElements];

    m_array_lablel_questions = [[NSMutableArray alloc]init];
    m_array_lablel_answers = [[NSMutableArray alloc]init];
    m_current_index = 0;
    
    m_scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,
                                                                 self.view.frame.size.width,
                                                                 self.view.frame.size.height-m_btn_next.frame.size.height-self.navigationController.navigationBar.frame.size.height-20)];
    
    m_scrollview.scrollEnabled = YES;
    m_scrollview.bounces = YES;
    m_scrollview.showsVerticalScrollIndicator = NO;
    m_scrollview.showsHorizontalScrollIndicator = NO;
    
//    m_scrollview.delegate = self;
    
    m_scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-m_btn_next.frame.size.height-self.navigationController.navigationBar.frame.size.height-20);
    
    NSUInteger count = [m_questions count];
   // NSLogExt(@"count=%i",count);
    for (NSUInteger i=0; i<count; i++) //num of questions
    {
        XMLCalcElement* obj =[m_questions objectAtIndex:i];
        NSUInteger count_items = [obj.m_subElements count];
        
        NSMutableArray *question_items = [[NSMutableArray alloc] init];
        for (NSUInteger j=0; j<count_items; j++)  //num of items in each question
        {
            XMLCalcElement* item = [obj.m_subElements objectAtIndex:j];
           
            [question_items addObject:item];
        }
        [m_array_lablel_questions addObject:question_items];
    }
    [self.view addSubview:m_scrollview];
   // m_scrollview.backgroundColor = [UIColor redColor];
    [self updateUI];
}
-(void) setShowAnswerButton : (BOOL) stateShow
{
    if (!stateShow)
    {
         [m_btn_showAnswer setTitle:@"显示答案" forState:UIControlStateNormal];
    }
    else
    {
         [m_btn_showAnswer setTitle:@"隐藏答案" forState:UIControlStateNormal];
    }
}
-(void) updateUI
{
    m_isShowingAnswer = NO;
    [self setShowAnswerButton: m_isShowingAnswer];
    
    NSMutableArray *question = [m_array_lablel_questions objectAtIndex:m_current_index];
    [m_array_lablel_answers removeAllObjects];
    
    m_max_height_question = 0 ;
    
    for (id obj in m_scrollview.subviews)
    {
        if ([obj viewWithTag:1])
        {
            [obj removeFromSuperview];
        }
    }
   
    for (NSUInteger i=0; i<[question count]; i++)
    {
        XMLCalcElement* item = [question objectAtIndex:i];
       // NSLogExt(@"ElementName=%@, tag=%@, value=%@",[item m_elementName],[item m_tag],[item m_value]);
        UILabel* lbl_item = [[UILabel alloc]init];
        lbl_item.tag = 1;
        
        
        if ([[item m_tag] isEqualToString:@"question"])
        {
            if ([[item m_elementName] isEqualToString:@"text"])
            {
                lbl_item.text = [item m_value];
                [Util setLabelToAutoSize:lbl_item];
                [m_scrollview addSubview:lbl_item];
                
            }
            else if ([[item m_elementName] isEqualToString:@"image"])
            {
                UIImage *itemBgImage = [UIImage imageNamed:[item m_value]];
                UIColor *color = [UIColor colorWithPatternImage:itemBgImage];
                [lbl_item setFrame:CGRectMake(0, 0, itemBgImage.size.width, itemBgImage.size.height)];
                lbl_item.backgroundColor = color;
                [m_scrollview addSubview:lbl_item];
            }
            else
            {
              
                return;
            }
            [lbl_item setFrame:CGRectMake(0, m_max_height_question, lbl_item.frame.size.width, lbl_item.frame.size.height)];
             m_max_height_question = lbl_item.frame.origin.y + lbl_item.frame.size.height;
        }
        if ([[item m_tag] isEqualToString:@"answer"])
        {
            if ([[item m_elementName] isEqualToString:@"text"])
            {
                lbl_item.text = [item m_value];
                [Util setLabelToAutoSize:lbl_item];
            }
            else if ([[item m_elementName] isEqualToString:@"image"])
            {
                UIImage *itemBgImage = [UIImage imageNamed:[item m_value]];
                UIColor *color = [UIColor colorWithPatternImage:itemBgImage];
                [lbl_item setFrame:CGRectMake(0, 0, itemBgImage.size.width, itemBgImage.size.height)];
                lbl_item.backgroundColor = color;
            }
            else
            {
                return;
            }
            [m_array_lablel_answers addObject:lbl_item];
        }
        
     }

}
-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [PlatformUtil ResizeUIToBottomLeft:m_btn_prev parentView:self.view];
    [PlatformUtil ResizeUIToBottomRight:m_btn_next parentView:self.view];
    [PlatformUtil ResizeUIToBottomCenter:m_btn_showAnswer parentView:self.view];
    
   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)btnPrevClick:(id)sender
{
    if (m_current_index-1 >= 0)
    {
        --m_current_index;
        [self updateUI];
    }
}

- (IBAction)btnNextClick:(id)sender
{
    if (m_current_index+1<[m_array_lablel_questions count])
    {
        ++m_current_index;
        [self updateUI];
    }
}

- (IBAction)btnShowAnswerClick:(id)sender {
    
     NSUInteger max_height_answer = m_max_height_question;
  
    if (!m_isShowingAnswer)
    {
       
        NSUInteger count = [m_array_lablel_answers count];
        for (NSUInteger i=0; i<count; i++)
        {
            UILabel *answer = [m_array_lablel_answers objectAtIndex:i];
            [answer setFrame:CGRectMake(0, max_height_answer, answer.frame.size.width, answer.frame.size.height)];
            max_height_answer = answer.frame.origin.y + answer.frame.size.height;
            [m_scrollview addSubview:answer];
        }
        m_scrollview.contentSize = CGSizeMake(self.view.frame.size.width, max_height_answer);
        m_isShowingAnswer = YES;
    }
    else
    {
        NSUInteger count = [m_array_lablel_answers count];
       // NSLogExt(@"count=%i",count);
        for (NSUInteger i=0; i<count; i++)
        {
            UILabel *answer = [m_array_lablel_answers objectAtIndex:i];
            [answer removeFromSuperview];
        }
        m_scrollview.contentSize = CGSizeMake(self.view.frame.size.width, max_height_answer);
        m_isShowingAnswer = NO;
    }
      [self setShowAnswerButton: m_isShowingAnswer];
}

- (void)dealloc {
    [m_btn_prev release];
    [m_btn_next release];
    [m_btn_showAnswer release];
    [m_array_lablel_answers removeAllObjects];
    [m_array_lablel_answers release];
    [m_array_lablel_questions removeAllObjects];
    [m_array_lablel_questions release];
    [super dealloc];
}

@end
