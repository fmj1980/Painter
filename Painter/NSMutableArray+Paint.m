//
//  NSMutableArray+Stack.m
//  Painter
//
//  Created by fmj on 14-5-6.
//  Copyright (c) 2014年 fmj. All rights reserved.
//

#import "NSMutableArray+Paint.h"
#import "objc/runtime.h"
static char keyErase;
static char keyPaintColor;

@implementation NSMutableArray (Paint)
-(BOOL)erase
{
    NSNumber* value = objc_getAssociatedObject(self, &keyErase);
    if ( value == nil ) {
        return NO;
    }
    return [value boolValue];
}

-(void)setErase:(BOOL)erase
{
    objc_setAssociatedObject(self, &keyErase, @(erase), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor*)paintColor
{
    UIColor* color = objc_getAssociatedObject(self, &keyPaintColor);
    if (color == nil ) {
        return [UIColor redColor];
    }
    return color;
}

-(void)setPaintColor:(UIColor *)paintColor
{
    objc_setAssociatedObject(self, &keyPaintColor, paintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) push:(id)object
{
    if (object != nil)
        [self addObject:object];
}

- (id) pop
{
    if ([self count] == 0) return nil;
    
    id object = [self lastObject];
    [self removeLastObject];
    
    return object;
}

- (void) dropBottom
{
    if ([self count] == 0) return;
    
    [self removeObjectAtIndex:0];
}

@end
