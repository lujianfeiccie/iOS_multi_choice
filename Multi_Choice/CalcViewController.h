//
//  CalcViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-10-14.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "AbstractViewController.h"
#import "AppDelegate.h"
#import "XMLCalcHelper.h"
#import "UILabelExt.h"
@interface CalcViewController : AbstractViewController
{
    AppDelegate *app;
    XMLCalcHelper *m_xmlHelper;
     NSMutableArray* m_questions;
    IBOutlet UIButton *m_btn_prev;
    IBOutlet UIButton *m_btn_next;
    
    IBOutlet UIButton *m_btn_showAnswer;
    NSMutableArray *m_array_lablel_questions;
    NSMutableArray *m_array_lablel_answers;
    UIScrollView *m_scrollview;
    
    NSInteger m_current_index;
    
    NSUInteger m_max_height_question;
    
    BOOL m_isShowingAnswer;
}
- (IBAction)btnPrevClick:(id)sender;
- (IBAction)btnNextClick:(id)sender;
- (IBAction)btnShowAnswerClick:(id)sender;

@property(nonatomic,strong) NSString* m_title;
@property(nonatomic,strong) NSString* m_filename;
@end
