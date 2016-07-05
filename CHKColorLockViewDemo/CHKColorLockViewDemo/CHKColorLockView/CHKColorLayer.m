//
//  CHKColorLayer.m
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/5/23.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import "CHKColorLayer.h"

#define CHK_MAX_PRESSEURE 6.666667
@implementation CHKColorLayer

/**
 *  init
 */
-(instancetype)init {
    if (self = [super init]) {
        self.contentsScale = [UIScreen mainScreen].scale;
        _length = 0;
        // default color 
        _blockColor1 = [UIColor redColor];
        _blockColor2 = [UIColor blueColor];
        _blockColor3 = [UIColor greenColor];
        _blockColor4 = [UIColor purpleColor];
    }
    
    return self;
}

-(instancetype)initWithLayer:(CHKColorLayer *)layer {
    if (self = [super initWithLayer:layer]) {
        _length = layer.length;
        _blockColor1 = layer.blockColor1;
        _blockColor2 = layer.blockColor2;
        _blockColor3 = layer.blockColor3;
        _blockColor4 = layer.blockColor4;
    }
    
    return self;
}

-(void)setVisible:(BOOL)visible {
    _visible = visible;
    [self setNeedsDisplay];
}


-(UIColor *)colorWithPressureValue:(CGFloat)pressureValue {
    CGFloat pressureRate = pressureValue  / CHK_MAX_PRESSEURE;
    if (pressureRate <= 0.25) {
        return _blockColor1;
    }else if (pressureRate > 0.25 && pressureRate <= 0.5) {
        return _blockColor2;
    }else if (pressureRate > 0.5 && pressureRate <= 0.75) {
        return _blockColor3;
    }else {
        return _blockColor4;
    }
}

-(BOOL)setColors:(NSArray *)colorArray {
    if (colorArray.count != 4) {
        return NO;
    }
    for (id object in colorArray) {
        if (![object isKindOfClass:[UIColor class]]) {
            return NO;
        }
    }
    _blockColor1 = [colorArray objectAtIndex:0];
    _blockColor2 = [colorArray objectAtIndex:1];
    _blockColor3 = [colorArray objectAtIndex:2];
    _blockColor4 = [colorArray objectAtIndex:3];
    [self setNeedsDisplay];
    return YES;
}


/**
 *  draw context
 */
-(void)drawInContext:(CGContextRef)ctx {
    CGFloat lockViewWidth = self.frame.size.width;
    CGFloat lockViewHeight = self.frame.size.height;
    
    CGFloat r = lockViewWidth / 2;
    CGFloat d = _length;
    CGPoint o =  CGPointMake(lockViewWidth / 2, lockViewHeight);
    
    // first block
    UIBezierPath *blockPath1 = [UIBezierPath bezierPath];
    [blockPath1 moveToPoint:CGPointMake(0, lockViewHeight)];
    [blockPath1 addArcWithCenter:o radius:r startAngle:M_PI endAngle:1.25 * M_PI clockwise:YES];
    CGPoint tempPoint = blockPath1.currentPoint;
    [blockPath1 addLineToPoint:CGPointMake((d / r) * (o.x - tempPoint.x) + tempPoint.x,(d / r) *(o.y - tempPoint.y) + tempPoint.y)];
    [blockPath1 addArcWithCenter:o radius:r - d startAngle:1.25 * M_PI endAngle:M_PI clockwise:NO];
    [blockPath1 closePath];
    
    // second block
    UIBezierPath *blockPath2 = [UIBezierPath bezierPath];
    [blockPath2 moveToPoint:tempPoint];
    [blockPath2 addArcWithCenter:o radius:r startAngle:1.25 * M_PI endAngle:1.50 * M_PI clockwise:YES];
    tempPoint = blockPath2.currentPoint;
    [blockPath2 addLineToPoint:CGPointMake(tempPoint.x, tempPoint.y - d)];
    [blockPath2 addArcWithCenter:o radius:r - d startAngle:1.50 * M_PI endAngle:1.25 * M_PI clockwise:NO];
    [blockPath2 closePath];
    
    
    // third block
    UIBezierPath *blockPath3 = [UIBezierPath bezierPath];
    [blockPath3 moveToPoint:tempPoint];
    [blockPath3 addArcWithCenter:o radius:r startAngle:1.50 * M_PI endAngle:1.75 * M_PI clockwise:YES];
    tempPoint = blockPath3.currentPoint;
    [blockPath3 addLineToPoint:CGPointMake((r-d)/r * (tempPoint.x - o.x) + o.x, (d / r) * (o.y - tempPoint.y) + tempPoint.y)];
    [blockPath3 addArcWithCenter:o radius:r - d startAngle:1.75 * M_PI endAngle:1.50 * M_PI clockwise:NO];
    [blockPath3 closePath];
    
    
    //fourth block
    UIBezierPath *blockPath4 = [UIBezierPath bezierPath];
    [blockPath4 moveToPoint:tempPoint];
    [blockPath4 addArcWithCenter:o radius:r startAngle:1.75 * M_PI endAngle:0 clockwise:YES];
    [blockPath4 addLineToPoint:CGPointMake(lockViewWidth - d, lockViewHeight)];
    [blockPath4 addArcWithCenter:o radius:r - d startAngle:0 endAngle:1.75 * M_PI clockwise:NO];
    [blockPath4 closePath];
    
    // alpha
    CGFloat alpha;
    if (_visible) {
        alpha = 1.0f;
    }else {
        alpha = 0;
    }
    
    // draw
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextAddPath(ctx, blockPath1.CGPath);
    CGContextSetFillColorWithColor(ctx, [_blockColor1 colorWithAlphaComponent:alpha].CGColor);
    CGContextFillPath(ctx);
    CGContextAddPath(ctx, blockPath2.CGPath);
    CGContextSetFillColorWithColor(ctx, [_blockColor2 colorWithAlphaComponent:alpha].CGColor);
    CGContextFillPath(ctx);
    CGContextAddPath(ctx, blockPath3.CGPath);
    CGContextSetFillColorWithColor(ctx, [_blockColor3 colorWithAlphaComponent:alpha].CGColor);
    CGContextFillPath(ctx);
    CGContextAddPath(ctx, blockPath4.CGPath);
    CGContextSetFillColorWithColor(ctx, [_blockColor4 colorWithAlphaComponent:alpha].CGColor);
    CGContextFillPath(ctx);
    
    
    
}


@end
