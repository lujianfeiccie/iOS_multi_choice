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
@interface CalcViewController : AbstractViewController
{
    AppDelegate *app;
    XMLCalcHelper *m_xmlHelper;
     NSMutableArray* m_questions;
}
@property(nonatomic,strong) NSString* m_title;
@property(nonatomic,strong) NSString* m_filename;
@end
