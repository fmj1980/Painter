//
//  PainterView.m
//  Painter
//
//  Created by fmj on 14-5-6.
//  Copyright (c) 2014年 fmj. All rights reserved.
//

#import "PainterView.h"
#import "NSMutableArray+Paint.h"

@interface PainterView()

@property(nonatomic,retain) NSMutableArray* scribbles;

@end

@implementation PainterView
{
    NSMutableArray* _currentPoints;
    NSMutableArray* _revokes;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    _paintColor = [UIColor redColor];
    _scribbles = [[NSMutableArray alloc] init];
    _revokes = [[NSMutableArray alloc] init];
    _paintWidth = 5.0;
    _eraseWidth = 7.0;
    _erase = NO;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowOffset = CGSizeMake(5, 5);
    self.backgroundColor = [UIColor whiteColor];

}

-(void)revoke
{
    if (_scribbles.count==0) {
        return;
    }
    [_revokes push:[_scribbles pop]];
    [self setNeedsDisplay];
}

-(void)redo
{
    if (_revokes.count == 0) {
        return;
    }
    [_scribbles push:[_revokes pop]];
    [self setNeedsDisplay];
}

-(void)load
{
    NSString* filePath = [[self directory:NSDocumentDirectory] stringByAppendingPathComponent:@"paint"];
    NSData *data =[NSData dataWithContentsOfFile:filePath];
    @try {
        _scribbles = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *exception) {
        return;
    }
    [_revokes removeAllObjects];
    [self setNeedsDisplay];
}

-(void)save
{
    NSString* filePath = [[self directory:NSDocumentDirectory] stringByAppendingPathComponent:@"paint"];
    NSData *PersistentData =[NSKeyedArchiver archivedDataWithRootObject:_scribbles];
    [PersistentData writeToFile:filePath atomically:YES];
}

-(void)newPaint
{
    [_scribbles removeAllObjects];
    [_revokes removeAllObjects];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Drawing code
    for (NSMutableArray* arry in _scribbles) {
        if (arry.erase) {
            CGContextSetLineWidth(context, _eraseWidth);
            CGContextSetStrokeColorWithColor(context, self.backgroundColor.CGColor);
        }
        else
        {
            CGContextSetLineWidth(context, _paintWidth);
            CGContextSetStrokeColorWithColor(context, arry.paintColor.CGColor);
            
        }
        for (int index = 0; index<arry.count; index++) {
            NSValue* value = [arry objectAtIndex:index];
            CGPoint point  =  [value CGPointValue];
            if (index == 0 ) {
                CGContextMoveToPoint(context, point.x, point.y);
            }
            else
            {
                CGContextAddLineToPoint(context, point.x, point.y);
            }
        }
        CGContextStrokePath(context);
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_revokes removeAllObjects];
    _currentPoints = [[NSMutableArray alloc] init];
    _currentPoints.erase = self.erase;
    _currentPoints.paintColor = self.paintColor;
     [_scribbles addObject:_currentPoints];
    
    CGPoint point = [[touches anyObject] locationInView:self];
    [_currentPoints addObject:[NSValue valueWithCGPoint:point]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    [_currentPoints addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _currentPoints = nil;
    [self setNeedsDisplay];
}

- (NSString *)directory:(NSSearchPathDirectory)dir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( dir, NSUserDomainMask, YES);
    
    NSString *dirStr;
    if ([paths count] > 0){
        dirStr = [NSString stringWithFormat:@"%@", paths[0]];
    }
    else
    {
        //可能出现吗？ 搞不清楚
        dirStr = [NSString stringWithFormat:@"~/"];
    }
    return dirStr;
}
@end
