//
//  ViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-8-22.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLHelper.h"
@interface ViewController : UIViewController
{
    __weak IBOutlet UILabel *m_lbl_title;
    __weak IBOutlet UILabel *m_lbl_choice1;
    __weak IBOutlet UILabel *m_lbl_choice2;
    XMLHelper* m_xmlHelper;
    NSInteger m_count;
    NSMutableArray* m_questions;
    NSInteger m_currentIndex;
}
- (IBAction)btnNextClick:(id)sender;
- (IBAction)btnPrevClick:(id)sender;
- (void) updateQuestionView;
@end
