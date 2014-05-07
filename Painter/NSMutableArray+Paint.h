//
//  NSMutableArray+Stack.h
//  Painter
//
//  Created by fmj on 14-5-6.
//  Copyright (c) 2014年 fmj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Paint)

@property(nonatomic) BOOL erase;
@property(nonatomic) UIColor* paintColor;

- (void) push:(id)object;
- (id) pop;
- (void) dropBottom;

@end
