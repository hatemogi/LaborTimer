//
//  BTCircleButton.m
//  BabyTimer
//
//  Created by hatemogi on 2014. 2. 6..
//  Copyright (c) 2014년 hatemogi. All rights reserved.
//

#import "BTCircleButton.h"

@implementation BTCircleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    [self.titleLabel.textColor setStroke];
    [self.titleLabel.shadowColor setFill];

    CGRect myframe = CGRectInset(self.bounds, 3, 3);
    
    CGContextSetLineWidth(ctx, 2);
    CGContextAddEllipseInRect(ctx, myframe);
    CGContextFillPath(ctx);
    CGContextAddEllipseInRect(ctx, myframe);
    CGContextStrokePath(ctx);
    NSLog(@"%d", self.state);
}

@end
