//
//  CHKButtonView.m
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/5/26.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import "CHKButtonView.h"

@implementation CHKButtonView

#pragma  mark init
-(instancetype)init {
    if (self = [super init]) {
        [self initSetup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSetup];
    }
    
    return self;
}

-(void)initSetup {
    _origin = CGPointMake(0, 0);
    _radiusPaddingWidth = 0;
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEventHandle:)];
    [self addGestureRecognizer:rec];
    [self setUserInteractionEnabled:YES];
}

-(void)setOrigin:(CGPoint)origin {
    _origin = origin;
    self.frame = CGRectMake(origin.x - self.frame.size.width / 2, origin.y - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [self setNeedsDisplay];
}

#pragma mark guestureRecognizer
-(void)tapEventHandle:(id)sender {
    if ([self.delegate respondsToSelector:@selector(CHKButtonViewDidTap:)]) {
        [self.delegate CHKButtonViewDidTap:self];
    }
}



#pragma mark draw
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, rect.size.height)];
    [path addArcWithCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height) radius:self.frame.size.width / 2 - _radiusPaddingWidth startAngle:M_PI endAngle:0 clockwise:YES];
    [path closePath];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetFillColorWithColor(ctx, _buttonColor.CGColor);
    CGContextFillPath(ctx);
    
}

#pragma mark touches Event
// begin press
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(CHKButtonViewDidBeginPress:)]) {
        [self.delegate CHKButtonViewDidBeginPress:self];
    }
}

// pressing
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat pressure = 0.0;
    CGPoint location = CGPointMake(0, 0);
    for (UITouch *touch in touches) {
        pressure = touch.force;
        location = [touch locationInView:nil];
    }
    if ([self.delegate respondsToSelector:@selector(CHKButtonViewDidPress:pressureValue:location:)]) {
        [self.delegate CHKButtonViewDidPress:self pressureValue:pressure location:location];
    }
}

// End press when raise
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"cancelled");
    if ([self.delegate respondsToSelector:@selector(CHKButtonViewDidEndPress:)]) {
        [self.delegate CHKButtonViewDidEndPress:self];
    }
}

// End press when move outside the screen
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"end");
    if ([self.delegate respondsToSelector:@selector(CHKButtonViewDidEndPress:)]) {
        [self.delegate CHKButtonViewDidEndPress:self];
    }
}


@end
