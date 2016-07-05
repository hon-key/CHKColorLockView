//
//  CHKPointerLayer.m
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/5/23.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//


#import "CHKPointerLayer.h"



#define CHK_MAX_PRESSEURE 6.666667
@interface CHKPointerLayer ()

@property (nonatomic,assign) CGPoint origin;

@property (nonatomic,assign) CGFloat radius;

@property (nonatomic,assign,readwrite) CGPoint coordinate;

@end

@implementation CHKPointerLayer

/**
 *  init
 */
-(instancetype)init {
    if (self = [super init]) {
        self.contentsScale = [UIScreen mainScreen].scale;
        _pressure = 0;
        _coordinate = CGPointMake(0, 0);
        _origin = CGPointMake(0, 0);
        _radius = 0;
        _pointerColor = [UIColor whiteColor];
        _distance = 0;
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self =  [super init]) {
        self.contentsScale = [UIScreen mainScreen].scale;
        self.frame = frame;
        _pressure = 0;
        _coordinate = CGPointMake(0, frame.size.height);
        _origin = CGPointMake(frame.size.width / 2, frame.size.height);
        _radius = frame.size.width / 2;
        _pointerColor = [UIColor whiteColor];
        _distance = 0;
    }
    return self;
}

-(instancetype)initWithLayer:(CHKPointerLayer *)layer {
    if (self = [super initWithLayer:layer]) {
        _pressure = layer.pressure;
        _coordinate = layer.coordinate;
        _origin = layer.origin;
        _radius = layer.radius;
        _pointerColor = [UIColor whiteColor];
        _distance = layer.distance;
    }
    
    return self;
}

-(void)setPressure:(CGFloat)pressure {
    _pressure = pressure;
    [self setNeedsDisplay];
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _origin = CGPointMake(frame.size.width / 2,frame.size.height);
    _radius = frame.size.width / 2;
    _coordinate = CGPointMake(0, frame.size.height);
}


/**
 *  draw context
 */
-(void)drawInContext:(CGContextRef)ctx {
    CGFloat pressureRate = _pressure  / CHK_MAX_PRESSEURE;
    CGFloat angle = 180 - 180 * pressureRate;
    _coordinate = [self calcCircleCoordinateWithCenter:_origin andWithAngle:angle andWithRadius:_radius];
    
    CGFloat innerRadius = _radius - _distance;
    CGPoint innerPoint = [self calcCircleCoordinateWithCenter:_origin andWithAngle:angle andWithRadius:innerRadius];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_coordinate];
    [path addLineToPoint:innerPoint];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetStrokeColorWithColor(ctx, _pointerColor.CGColor);
    CGContextSetLineWidth(ctx, 3.0f);
    CGContextStrokePath(ctx);
    
    
}

-(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius * cosf(angle * M_PI / 180);
    CGFloat y2 = radius * sinf(angle * M_PI / 180);
    return CGPointMake(center.x + x2, center.y - y2);
}

@end
