//
//  ViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-8-22.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLHelper.h"
#import "UILabelExt.h"
#import "AppDelegate.h"
@interface ViewController : UIViewController<UILabelExtDelegate,UIScrollViewDelegate>
{
    UIScrollView *m_scrollview;
     UILabel *m_lbl_title;
     UILabelExt *m_lbl_choice1;
     UILabelExt *m_lbl_choice2;
     UILabelExt *m_lbl_choice3;
     UILabelExt *m_lbl_choice4;
     UILabelExt *m_lbl_note;
    XMLHelper* m_xmlHelper;
    NSInteger m_count;
    NSMutableArray* m_questions;
    NSInteger m_currentIndex;
    NSString* m_str_answer;
    AppDelegate *app;
    __weak IBOutlet UIButton *m_btn_prev;
    __weak IBOutlet UIButton *m_btn_next;
}
@property(nonatomic,strong) NSString* m_filename;
- (IBAction)btnNextClick:(id)sender;
- (IBAction)btnPrevClick:(id)sender;
- (void) updateQuestionView;

@end
