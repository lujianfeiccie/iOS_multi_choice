//
//  Util.m
//  Multi_Choice
//
//  Created by Apple on 14-8-25.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "Util.h"

@implementation Util
+(void) setLabelToAutoSize:(UILabel*) label{
    [label setNumberOfLines:0];
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.textAlignment = NSTextAlignmentLeft;
    
    CGSize maximumSize = CGSizeMake(300, CGFLOAT_MAX); // 第一个参数是label的宽度，第二个参数是固定的宏定义，CGFLOAT_MAX
    CGSize expectedLabelSize = [label.text sizeWithFont:label.font
                                 constrainedToSize:maximumSize
                                     lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect newFrame = label.frame;
    newFrame.size.width = 320;
    newFrame.size.height = expectedLabelSize.height;
    label.frame = newFrame;
    [label sizeToFit];
}
@end
