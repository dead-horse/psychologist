//
//  FaceView.h
//  Psychologist
//
//  Created by he yiyu on 13-9-8.
//  Copyright (c) 2013年 he yiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FaceView;

@protocol FaceViewDataSource
- (float) smailForFace:(FaceView *) sender;
@end

@interface FaceView : UIView
@property (nonatomic) CGFloat scale;

- (void) handlePinch:(UIPinchGestureRecognizer *) gestrue;

@property (nonatomic, weak) id <FaceViewDataSource> datasource;
@end
