//
//  XMLCalcHelper.m
//  Multi_Choice
//
//  Created by Apple on 14-10-14.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "XMLCalcHelper.h"
#import "NSLogExt.h"
@implementation XMLCalcHelper

-(id) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void) load:(NSString*) fileName
{
    NSString* result = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    NSLogExt(@"filename=%@",fileName)
    NSData *data = [[NSData alloc]initWithContentsOfFile:result];
    
    self.parser = [[NSXMLParser alloc]initWithData:data];
    
    self.parser.delegate = self;
    
    if([self.parser parse])
    {
        
    }
}

// 文档开始
-(void)parserDidStartDocument:(NSXMLParser *)parser

{
    NSLogExt(@"parserDidStartDocument");
    self.rootElement = nil;
    
    self.currentElementPointer = nil;
    
}

// 文档结束
-(void)parserDidEndDocument:(NSXMLParser *)parser

{
    NSLogExt(@"parserDidEndDocument");
    self.currentElementPointer = nil;
    
}

// 元素开始
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict

{
    
    if(self.rootElement == nil){
        
        self.rootElement = [[XMLCalcElement alloc]init];
        
        self.currentElementPointer = self.rootElement;
        
    }else{
        
        XMLCalcElement *newElement = [[XMLCalcElement alloc]init];
        
        newElement.m_parent = self.currentElementPointer;
        
        [self.currentElementPointer.m_subElements addObject:newElement];
        
        self.currentElementPointer = newElement;
        
    }
    
    self.currentElementPointer.m_elementName = elementName;
    if ([self.currentElementPointer.m_elementName isEqual:@"question"])
    {
        self.currentElementPointer.m_question = [attributeDict objectForKey:@"text"];
        self.currentElementPointer.m_image_question = [attributeDict objectForKey:@"image"];
      //  NSLogExt(@"name:%@" , elementName);
    }
    else
    {
        self.currentElementPointer.m_answer = [attributeDict objectForKey:@"text"];
        self.currentElementPointer.m_image_answer = [attributeDict objectForKey:@"image"];
        
    }
   // NSLogExt(@"name:%@" , elementName);
}

// 元素结束

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName

{
    
    self.currentElementPointer = self.currentElementPointer.m_parent;
    
    //NSLogExt(@"end name:%@" , elementName);
    
}

// 解析文本,会多次解析，每次只解析1000个字符，如果多月1000个就会多次进入这个方法
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
  //  if([self.currentElementPointer.m_elementName isEqualToString:@"answer"])
     //   self.currentElementPointer.m_choice = string;
    
    
    
    // NSLogExt(@"string:%@" , string);
}

@end
