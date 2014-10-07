//
//  PlatformUtil.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "PlatformUtil.h"

@implementation PlatformUtil
+(void) ResizeUIAll: (UIView*) view
{
    for (id obj in view.subviews)
    {
        UIView* tmp = (UIView*)obj;
        [PlatformUtil ResizeUI:tmp];
    }
}
+(void) ResizeUI: (UIView*) view
{
    [view setFrame:CGRECT_HAVE_NAV(view.frame.origin.x,
                                  view.frame.origin.y,
                                  view.frame.size.width,
                                  view.frame.size.height)];
}

+(void) ResizeUIToBottom: (UIView*) view parentView :(UIView*) parentView
{
    [PlatformUtil ResizeUIToBottom:view parentView:parentView offSetY:0];
}
+(void) ResizeUIToBottom: (UIView*) view parentView :(UIView*) parentView offSetY :(NSInteger) offsetY
{
    [view setFrame:CGRectMake(view.frame.origin.x,
                              parentView.frame.size.height-view.frame.size.height+offsetY,
                              view.frame.size.width,
                              view.frame.size.height)];
}
+(void) ResizeUIToTop:(UIView*) view parentView :(UIView*) parentView
{
    [PlatformUtil ResizeUIToTop:view parentView:parentView offSetY:0];
}
+(void) ResizeUIToTop: (UIView*) view parentView :(UIView*) parentView offSetY :(NSInteger) offsetY
{
    [view setFrame:CGRectMake(view.frame.origin.x,
                              +offsetY,
                              view.frame.size.width,
                              view.frame.size.height)];
}
@end
