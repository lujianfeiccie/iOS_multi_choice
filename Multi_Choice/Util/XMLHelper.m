//
//  XMLHelper.m
//  Multi_Choice
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "XMLHelper.h"
#import "NSLogExt.h"
@implementation XMLHelper

-(id) init{
    self = [super init];
    if (self) {
        self.m_random = NO;
        m_questions = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void) load:(NSString*) fileName
{
    NSString* result = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:result];
    
    self.parser = [[NSXMLParser alloc]initWithData:data];
    
    self.parser.delegate = self;
    
    if([self.parser parse]){
        
      //  NSLogExt(@"The XML is Parsed");
        
        if (self.m_random == YES) {
            //srandom(time(NULL));
                   // NSLogExt(@"The data is randomed");
            NSMutableArray *questions = self.rootElement.m_subElements;

            int count_questions = [questions count];
            for (int i_q=0; i_q<count_questions; i_q++) {
                int j_q = arc4random() % (count_questions);
            //    NSLogExt(@"i=%i,j=%i",i_q,j_q);
                [questions exchangeObjectAtIndex:i_q withObjectAtIndex:j_q];
                
                NSMutableArray *choices = [[questions objectAtIndex:i_q] m_subElements];
                
                int count_choices = [choices count];
                for (int i_c=0; i_c<count_choices; i_c++) {
                    int j_c = arc4random() % (count_choices);
                    [choices exchangeObjectAtIndex:i_c withObjectAtIndex:j_c];
                }
            }
        }
       
        
       
    }else{
        
        NSLogExt(@"Failed to parse the XML");
        
    }

}

-(void) loadMultiple:(NSString *)fileName, ...
{
    va_list arguments;
    id eachObject;
    
    
    if (fileName) {
        NSLogExt(@"%@",fileName);
        
        
        NSString* result = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
        NSData *data = [[NSData alloc]initWithContentsOfFile:result];
        
        self.parser = [[NSXMLParser alloc]initWithData:data];
        
        self.parser.delegate = self;
        
        if([self.parser parse]){
            [m_questions addObjectsFromArray:self.rootElement.m_subElements];
        }
        va_start(arguments, fileName);
       
        
       
        while ((eachObject = va_arg(arguments, id))) {
            result = [[NSBundle mainBundle] pathForResource:eachObject ofType:@"xml"];
            data = [[NSData alloc]initWithContentsOfFile:result];
            
            self.parser = [[NSXMLParser alloc]initWithData:data];
            
            self.parser.delegate = self;
            
            if([self.parser parse]){
                [m_questions addObjectsFromArray:self.rootElement.m_subElements];
            }
            NSLogExt(@"%@",eachObject);
        }
        
        va_end(arguments);
    }
    // NSLogExt(@"The data is randomed");
  
    NSLogExt(@"count=%i",[m_questions count]);
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
        
        self.rootElement = [[XMLElement alloc]init];
        
        self.currentElementPointer = self.rootElement;
        
    }else{
        
        XMLElement *newElement = [[XMLElement alloc]init];
        
        newElement.m_parent = self.currentElementPointer;
        
        [self.currentElementPointer.m_subElements addObject:newElement];
        
        self.currentElementPointer = newElement;
        
    }
    
    self.currentElementPointer.m_elementName = elementName;
    
    self.currentElementPointer.m_title = [attributeDict objectForKey:@"title"];
    self.currentElementPointer.m_answer = [attributeDict objectForKey:@"answer"];
    self.currentElementPointer.m_note =[attributeDict objectForKey:@"note"];
 //   NSLogExt(@"name:%@" , elementName);
    
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
    
    if([self.currentElementPointer.m_elementName isEqualToString:@"choice"])
        self.currentElementPointer.m_choice = string;
    

    if([self.currentElementPointer.m_elementName isEqualToString:@"title"])
        self.currentElementPointer.m_title = string;
    
    
   // NSLogExt(@"string:%@" , string);
}
@end
