//
//  CHKOutputLayer.m
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/5/31.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import "CHKOutputLayer.h"

@interface CHKOutputLayer ()

@property (nonatomic,strong) NSMutableArray *colorArray;

@end

@implementation CHKOutputLayer

/**
 *  init
 */
-(instancetype)init {
    if (self = [super init]) {
        _colorArray = [NSMutableArray new];
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    
    return self;
}

-(instancetype)initWithLayer:(CHKOutputLayer *)layer {
    if (self = [super initWithLayer:layer]) {
        _colorArray = layer.colorArray;
    }
    return self;
}

-(void)pushColor:(UIColor *)color {
    if (!_colorArray) {
        _colorArray = [NSMutableArray new];
    }
    if (_colorArray.count >= 4) {
        return;
    }
    [_colorArray addObject:[color colorWithAlphaComponent:1.0f]];
    if ([_outputDelegate respondsToSelector:@selector(CHKOutputLayer:DidPickAColor:)]) {
        [_outputDelegate CHKOutputLayer:self DidPickAColor:[color copy]];
    }
    
    if (_colorArray.count == 4 && [_outputDelegate respondsToSelector:@selector(CHKOutputLayerDidPickAllColor:colorArray:)]) {
        [_outputDelegate CHKOutputLayerDidPickAllColor:self colorArray:[_colorArray copy]];
    }
    [self setNeedsDisplay];
}

-(void)popColor {
    if (!_colorArray) {
        _colorArray = [NSMutableArray new];
    }
    if (_colorArray.count == 0) {
        return;
    }
    [_colorArray removeObjectAtIndex:_colorArray.count - 1];
    [self setNeedsDisplay];
}

-(void)popAllColor {
    if (!_colorArray) {
        _colorArray = [NSMutableArray new];
    }
    if (_colorArray.count == 0) {
        return;
    }
    [_colorArray removeAllObjects];
    [self setNeedsDisplay];
}


/**
 *  draw context
 */
-(void)drawInContext:(CGContextRef)ctx {
    CGRect frame = self.frame;
    CGFloat selfWidth = frame.size.width;
    CGFloat selfHeight = frame.size.height;
    CGFloat roomWidth = selfWidth / 4;
    CGFloat roomHeight = selfHeight;
    CGFloat x = 0;
    CGFloat y = (roomHeight / 2);
    CGFloat smallCircleR = (roomWidth / 2 * 1/4);
    CGFloat bigCircleR = (roomWidth / 2 * 3/4);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(selfWidth, 0)];
    [path addLineToPoint:CGPointMake(selfWidth, selfHeight)];
    [path addLineToPoint:CGPointMake(0, selfHeight)];
    [path closePath];
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetFillColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    CGContextFillPath(ctx);
    
    // circle 
    for (int i = 1; i <= 4; i++) {
        [path removeAllPoints];
        if (_colorArray.count >= i) {
            x = ((i - 1) * roomWidth + roomWidth / 2);
            [path addArcWithCenter:CGPointMake(x, y) radius:bigCircleR startAngle:0 endAngle:2.0 * M_PI clockwise:YES];
            CGContextAddPath(ctx, path.CGPath);
            UIColor *tempColor = [_colorArray objectAtIndex:i - 1];
            CGContextSetFillColorWithColor(ctx, tempColor.CGColor);
            CGContextSetStrokeColorWithColor(ctx, tempColor.CGColor);
            CGContextFillPath(ctx);
            CGContextStrokePath(ctx);
        }else {
            x = ((i - 1) * roomWidth + roomWidth / 2);
            [path addArcWithCenter:CGPointMake(x, y) radius:smallCircleR startAngle:0 endAngle:2.0 * M_PI clockwise:YES];
            
            CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
            CGContextAddPath(ctx, path.CGPath);
            CGContextFillPath(ctx);
        }
    }
    
    
}


@end
