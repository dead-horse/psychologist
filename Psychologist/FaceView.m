//
//  FaceView.m
//  Psychologist
//
//  Created by he yiyu on 13-9-8.
//  Copyright (c) 2013年 he yiyu. All rights reserved.
//

#import "FaceView.h"

#define DEFAULT_SCALE 0.9

@implementation FaceView

@synthesize datasource = _datasource;

@synthesize scale = _scale;

- (void) setScale:(CGFloat)scale
{
    if (scale < 0) {
        scale = 0;
    }
    if (scale > 1) {
        scale = 1;
    }
    if (scale != _scale) {
        _scale = scale;
        [self setNeedsDisplay];
    }
}

- (CGFloat) scale
{
    if (!_scale) {
        return DEFAULT_SCALE;
    }
    return _scale;
}

- (void) handlePinch:(UIPinchGestureRecognizer *) gestrue
{
    if ((gestrue.state == UIGestureRecognizerStateChanged) ||
        (gestrue.state == UIGestureRecognizerStateEnded)) {
        self.scale *= gestrue.scale;
        gestrue.scale = 1;
    }
}

- (void) setup
{
    self.contentMode = UIViewContentModeRedraw;
}

- (void) awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat) radius inContext:(CGContextRef) context
{
    UIGraphicsPushContext(context);
    
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2 * M_PI, YES);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}

- (void)drawRect:(CGRect)rect
{
    //get context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //set line and color
    CGContextSetLineWidth(context, 3);
    [[UIColor blueColor] setStroke];

    //draw face
    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width / 2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height / 2;
    
    CGFloat size = self.bounds.size.width / 2;
    if (self.bounds.size.width > self.bounds.size.height) {
        size = self.bounds.size.height / 2;
    }
    size *= self.scale;
    [self drawCircleAtPoint:midPoint withRadius:size inContext:context];
    
    //draw eyes
    #define EYE_H 0.35
    #define EYE_V 0.35
    #define EYE_RADIUS 0.1
    
    CGPoint eyePoint;
    CGFloat eyeSize = size * EYE_RADIUS;
    
    eyePoint.x = midPoint.x - EYE_H * size;
    eyePoint.y = midPoint.y - EYE_V * size;
    [self drawCircleAtPoint:eyePoint withRadius:eyeSize inContext:context];
    
    eyePoint.x = midPoint.x + EYE_H * size;
    eyePoint.y = midPoint.y - EYE_V * size;
    
    [self drawCircleAtPoint:eyePoint withRadius:eyeSize inContext:context];
    
    //draw mouth
    
    #define MOUTH_H 0.45
    #define MOUTH_V 0.4
    #define MOUTH_SMILE 0.25
    
    CGPoint mouthStart;
    mouthStart.x = midPoint.x - MOUTH_H * size;
    mouthStart.y = midPoint.y + MOUTH_V * size;
    CGPoint mouthEnd;
    mouthEnd.x = midPoint.x + MOUTH_H * size;
    mouthEnd.y = mouthStart.y;
    
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x += MOUTH_H * size * 2/3;
    CGPoint mouthCP2 = mouthEnd;
    mouthCP2.x -= MOUTH_H * size * 2/3;
    
    float smile = [self.datasource smailForFace:self];
    if (smile > 1) {
        smile = 1;
    }
    if (smile < -1) {
        smile = -1;
    }
    
    CGFloat smileOffset = MOUTH_SMILE * size * smile;
    mouthCP1.y += smileOffset;
    mouthCP2.y += smileOffset;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP1.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
    CGContextStrokePath(context);
}
@end
