//
//  CHKCircularLayer.m
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/5/23.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import "CHKCircularLayer.h"

@implementation CHKCircularLayer

/**
 *  init
 */
-(instancetype)init {
    if (self = [super init]) {
        self.contentsScale = [UIScreen mainScreen].scale;
        _backColor = [UIColor clearColor];
        _distance = 0;
    }
    
    return self;
}

-(instancetype)initWithLayer:(CHKCircularLayer *)layer {
    if (self = [super initWithLayer:layer]) {
        _backColor = layer.backColor;
        _distance = layer.distance;
    }
    
    return self;
}


/**
 *  draw context
 */
-(void)drawInContext:(CGContextRef)ctx {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat lockViewWidth = self.frame.size.width;
    CGFloat lockViewHeight = self.frame.size.height;
    
    [path moveToPoint:CGPointMake(0, lockViewHeight)];
    [path addArcWithCenter:CGPointMake(lockViewWidth / 2, lockViewHeight) radius:lockViewWidth / 2 startAngle:M_PI endAngle:0 clockwise:YES];
    [path moveToPoint:CGPointMake(lockViewWidth - _distance, lockViewHeight)];
    [path addArcWithCenter:CGPointMake(lockViewWidth / 2, lockViewHeight) radius:(lockViewWidth - _distance * 2) / 2 startAngle:0 endAngle:M_PI clockwise:NO];
    [path closePath];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetFillColorWithColor(ctx, _backColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);
    
}

@end
