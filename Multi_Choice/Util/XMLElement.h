//
//  XMLElement.h
//  Multi_Choice
//
//  Created by Apple on 14-8-22.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLElement : NSObject
@property (nonatomic,strong) NSString *m_elementName;
@property (nonatomic,strong) NSString *m_title;
@property (nonatomic,strong) NSString *m_answer;
@property (nonatomic,strong) NSString *m_choice;
@property (nonatomic,strong) NSMutableArray *m_subElements;
@property (nonatomic,strong) XMLElement *m_parent;
@end
