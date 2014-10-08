//
//  DialogUtil.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DialogUtil;

//接口定义
@protocol DialogUtilDelegate <NSObject>
@required
#pragma marks -- DialogUtilDelegate --
-(void) onDialogConfirmClick : (DialogUtil*) dialog;
-(void) onDialogCancelClick : (DialogUtil*) dialog;
@end

@interface DialogUtil : NSObject<UIAlertViewDelegate>
{
id<DialogUtilDelegate> delegate;
}
@property(nonatomic,retain) id delegate;

-(void) showDialogTitle: (NSString *)title message:(NSString *)message confirm :(NSString*) confirm;
-(void) showDialogTitle: (NSString *)title message:(NSString *)message confirm :(NSString*) confirm cancel :(NSString*) cancel;
@end
