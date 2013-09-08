//
//  HappinessViewController.m
//  Psychologist
//
//  Created by he yiyu on 13-9-8.
//  Copyright (c) 2013年 he yiyu. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController() <FaceViewDataSource>
@property (nonatomic, weak) IBOutlet FaceView *faceView;

@end

@implementation HappinessViewController

@synthesize happiness = _happiness;
@synthesize faceView = _faceView;

- (void) setHappiness:(int)happiness
{
    if (happiness > 100) {
        happiness = 100;
    }
    if (happiness < 0) {
        happiness = 0;
    }
    _happiness = happiness;
    
    //every time set happiness, redraw
    [self.faceView setNeedsDisplay];
}

- (void) setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(handlePinch:)]];
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappinessGesture:)]];
    //delegate
    self.faceView.datasource = self;
}

//protocol method
- (float) smailForFace:(FaceView *)sender
{
    return (self.happiness - 50) / 50.0;
}

- (void) handleHappinessGesture:(UIPanGestureRecognizer *) gestrue
{
    if (gestrue.state == UIGestureRecognizerStateChanged ||
        gestrue.state == UIGestureRecognizerStateEnded) {
        CGPoint translation = [gestrue translationInView:self.faceView];
        self.happiness -= translation.y / 2;
        [gestrue setTranslation:CGPointZero inView:self.faceView];
    }
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (BOOL) shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
