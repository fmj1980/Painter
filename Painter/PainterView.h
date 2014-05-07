//
//  PainterView.h
//  Painter
//
//  Created by fmj on 14-5-6.
//  Copyright (c) 2014年 fmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PainterView : UIView

//绘制的颜色
@property(nonatomic,retain) UIColor* paintColor;
//绘制的宽度
@property(nonatomic) CGFloat paintWidth;
//橡皮擦的宽度
@property(nonatomic) CGFloat eraseWidth;
//橡皮擦
@property(nonatomic) BOOL erase;
//单步撤销
-(void)revoke;
//单步继续
-(void)redo;
//保存
-(void)save;
//加载保存的
-(void)load;
//新建
-(void)newPaint;
@end
