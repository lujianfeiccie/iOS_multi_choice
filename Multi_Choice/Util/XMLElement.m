//
//  XMLElement.m
//  Multi_Choice
//
//  Created by Apple on 14-8-22.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "XMLElement.h"

@implementation XMLElement

@synthesize m_title;
@synthesize m_answer;
@synthesize m_choice;
@synthesize m_parent;
@synthesize m_subElements;


-(NSMutableArray*) m_subElements{
    if(m_subElements == nil){
        m_subElements = [[NSMutableArray alloc]init];
    }
    return m_subElements;
}
@end
