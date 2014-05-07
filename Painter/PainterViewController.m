//
//  PainterViewController.m
//  Painter
//
//  Created by fmj on 14-5-6.
//  Copyright (c) 2014年 fmj. All rights reserved.
//

#import "PainterViewController.h"
#import "PainterView.h"


@interface PainterViewController ()
@property (weak, nonatomic) IBOutlet PainterView *paintView;
@end

@implementation PainterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearButtonClicked:(UIButton *)sender
{
    _paintView.erase = !_paintView.erase;
}

- (IBAction)colorButtonClicked:(UIButton *)sender
{
    _paintView.paintColor = sender.backgroundColor;
}

- (IBAction)cancelButtonClicked:(UIButton *)sender
{
    [_paintView revoke];
}

- (IBAction)redoButtonClicked:(UIButton *)sender
{
    [_paintView redo];
}

- (IBAction)newButtonClicked:(UIButton *)sender
{
    [_paintView newPaint];
}

- (IBAction)saveButtonClicked:(UIButton *)sender
{
    [_paintView save];
}

- (IBAction)loadButtonClicked:(UIButton *)sender
{
    [_paintView load];
}

@end
