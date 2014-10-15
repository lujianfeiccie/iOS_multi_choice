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

    m_array_lablel_questions = [[NSMutableArray alloc]init];
    m_array_lablel_answers = [[NSMutableArray alloc]init];
    
    NSUInteger count = [m_questions count];
    m_max_height_question=-1;
    
    m_scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,
                                                                 self.view.frame.size.width,
                                                                 self.view.frame.size.height-m_btn_next.frame.size.height-self.navigationController.navigationBar.frame.size.height-20)];
    
    m_scrollview.scrollEnabled = YES;
    m_scrollview.bounces = YES;
    m_scrollview.showsVerticalScrollIndicator = NO;
    m_scrollview.showsHorizontalScrollIndicator = NO;
    
//    m_scrollview.delegate = self;
    
    m_scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-m_btn_next.frame.size.height-self.navigationController.navigationBar.frame.size.height-20);
    
    for (NSUInteger i=0; i<count; i++) {
        XMLCalcElement* obj =[m_questions objectAtIndex:i];
       // NSLogExt(@"Question text=%@ image=%@",obj.m_question,obj.m_image_question);
        UILabelExt *lbl_title = [[UILabelExt alloc]init];
        lbl_title.userInteractionEnabled = YES;
        if (m_max_height_question==-1)
        {
          [lbl_title setFrame:CGRectMake(0, 0, 10, 10)];
        }
        else
        {
          [lbl_title setFrame:CGRectMake(0, m_max_height_question+20, 10, 10)];
        }
        lbl_title.text = obj.m_question;
        [Util setLabelToAutoSize:lbl_title];
        m_max_height_question = lbl_title.frame.origin.y+lbl_title.frame.size.height;
        ///////////////////////////////////////////////////////////////////
        [m_array_lablel_questions addObject:lbl_title];
        [m_scrollview addSubview:lbl_title];
        lbl_title.delegateExt = self;
        /////////////////////////////////////////////////////////////////
        XMLCalcElement *obj_answer = [[obj m_subElements] objectAtIndex:0];
        
        UILabel *lbl_answer = [[UILabel alloc]init];
        [lbl_answer setFrame:CGRectMake(0, 0, 10, 10)];
        lbl_answer.text = obj_answer.m_answer;
        [Util setLabelToAutoSize:lbl_answer];
      //  height_tmp = lbl_answer.frame.origin.y+lbl_answer.frame.size.height;
        [m_array_lablel_answers addObject:lbl_answer];
    
        [lbl_answer setHidden:YES];
        //NSLogExt(@"Answer text=%@ image=%@",obj_answer.m_answer,obj_answer.m_image_answer);
    }
    m_max_height_answer = m_max_height_question;
    
    for (NSUInteger i=0; i<count; i++) {
        UILabel* lbl_answer = [m_array_lablel_answers objectAtIndex:i];
        [lbl_answer setFrame:CGRectMake(lbl_answer.frame.origin.x, m_max_height_answer,
                                        lbl_answer.frame.size.width ,lbl_answer.frame.size.height)];
        
        m_max_height_answer = lbl_answer.frame.origin.y + lbl_answer.frame.size.height;
        [m_scrollview addSubview:lbl_answer];
    }
        [self.view addSubview:m_scrollview];
        m_scrollview.backgroundColor = [UIColor redColor];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) onLabelExtClick:(id)sender
{
//    NSLog(@"onLabelExtClick ");
    /*NSUInteger count = [m_array_lablel_questions count];
    for (NSUInteger i=0; i<count; i++) {
        UILabel *lbl_question =[m_array_lablel_questions objectAtIndex:i];
       if(lbl_question == sender)
       {
           NSLogExt(@"onLabelExtClick %i",i);
           UILabel *lbl_answer = [m_array_lablel_answers objectAtIndex:i];
          
           [lbl_answer setHidden:NO];
           
           
       }
    }
     */
}

- (void)dealloc {
    [m_btn_prev release];
    [m_btn_next release];
    [m_btn_showAnswer release];
    [super dealloc];
}
- (IBAction)btnPrevClick:(id)sender {
}

- (IBAction)btnNextClick:(id)sender {
}

- (IBAction)btnShowAnswerClick:(id)sender {
    NSUInteger count = [m_array_lablel_answers count];
     for (NSUInteger i=0; i<count; i++)
     {
         UILabel *lbl_answer = [m_array_lablel_answers objectAtIndex:i];
         [lbl_answer setHidden:NO];
     }
     m_scrollview.contentSize = CGSizeMake(self.view.frame.size.width,
        m_max_height_answer);
}
@end
