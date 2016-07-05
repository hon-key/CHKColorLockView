//
//  CHKColorLockView.m
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/5/23.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import "CHKColorLockView.h"
#import "CHKCircularLayer.h"
#import "CHKColorLayer.h"
#import "CHKPointerLayer.h"
#import "CHKButtonView.h"
#import "CHKOutputLayer.h"
#import "CHKColorPasswordManager.h"

@interface CHKColorLockView ()<CHKButtonViewDelegate,CHKOutputLayerDelegate>


/**
 *  unlock backgroundView
 */
@property (nonatomic,strong) UIView *unlockBackgroundView;

/**
 *  circular Layer
 */
@property (nonatomic,strong) CHKCircularLayer *circularLayer;

/**
 *  color Layer
 */
@property (nonatomic,strong) CHKColorLayer *colorLayer;

/**
 *  pointer Layer
 */
@property (nonatomic,strong) CHKPointerLayer *pointerLayer;

/**
 *  button Layer
 */
@property (nonatomic,strong) CHKButtonView *buttonView;

@property (nonatomic,strong) UILabel *finishedLabel;

@property (nonatomic,strong) CHKOutputLayer *outputLayer;

@property (nonatomic,strong) UIButton *deleteButton;

/**
 *  unlock layer width and height
 */
@property (nonatomic,assign) CGFloat unlockLayerWidth;
@property (nonatomic,assign) CGFloat unlockLayerHeight;
@property (nonatomic,assign) CGFloat distance;
@property (nonatomic,assign) BOOL isInside;


@end

@implementation CHKColorLockView

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

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initSetup];
    }
    return self;
}

-(void)initSetup {
    if (self.frame.size.height >= self.frame.size.width) {
        _unlockLayerWidth = self.frame.size.width * 6/7;
        _unlockLayerHeight = _unlockLayerWidth / 2;
    }else {
        _unlockLayerWidth = self.frame.size.height * 6/7;
        _unlockLayerHeight = _unlockLayerWidth / 2;
    }
    _distance = _unlockLayerWidth / 2 * 0.6;
    self.backgroundColor = [UIColor whiteColor];
    self.unlockBackgroundView.backgroundColor = [UIColor clearColor];
    [self.circularLayer setNeedsDisplay];
    [self.colorLayer setNeedsDisplay];
    [self.pointerLayer setNeedsDisplay];
    self.buttonView.backgroundColor = [UIColor clearColor];
    self.finishedLabel.backgroundColor = [UIColor greenColor];
    [self.outputLayer setNeedsDisplay];
    self.deleteButton.backgroundColor = [UIColor clearColor];
    
    CHKColorPasswordManager *manager = [[CHKColorPasswordManager alloc] init];
    [manager saveColorPassword:@[[UIColor blueColor],[UIColor redColor],[UIColor blueColor],[UIColor redColor]]];
    
}

#pragma mark Init
-(UIView *)unlockBackgroundView {
    if (!_unlockBackgroundView) {
        _unlockBackgroundView = [[UIView alloc] init];
        CGFloat selfHeight = self.frame.size.height;
        CGFloat selfWidth = self.frame.size.width;
        _unlockBackgroundView.frame = CGRectMake(selfWidth / 2 - _unlockLayerWidth / 2, selfHeight - _unlockLayerHeight - selfHeight * 1/10, _unlockLayerWidth, _unlockLayerHeight);
        _unlockBackgroundView.layer.masksToBounds = YES;
        [self addSubview:_unlockBackgroundView];
    }
    return _unlockBackgroundView;
}

-(CHKCircularLayer *)circularLayer {
    if (!_circularLayer) {
        _circularLayer = [[CHKCircularLayer alloc] init];
        _circularLayer.frame = self.unlockBackgroundView.bounds;
        _circularLayer.backColor = [UIColor clearColor];
        _circularLayer.distance = _distance;
        [self.unlockBackgroundView.layer addSublayer:_circularLayer];
    }
    
    return _circularLayer;
}

-(CHKColorLayer *)colorLayer {
    if (!_colorLayer) {
        _colorLayer = [[CHKColorLayer alloc] init];
        _colorLayer.frame = self.unlockBackgroundView.bounds;
        _colorLayer.length = _distance;
        _colorLayer.visible = NO;
        [self.unlockBackgroundView.layer addSublayer:_colorLayer];
    }
    
    return _colorLayer;
}

-(CHKPointerLayer *)pointerLayer {
    if (!_pointerLayer) {
        _pointerLayer = [[CHKPointerLayer alloc] initWithFrame:self.unlockBackgroundView.bounds];
        _pointerLayer.distance = _distance;
        _pointerLayer.pointerColor = [UIColor whiteColor];
        _pointerLayer.pressure = 0.0;
        [self.unlockBackgroundView.layer addSublayer:_pointerLayer];
    }
    return _pointerLayer;
}

-(CHKButtonView *)buttonView {
    if (!_buttonView) {
        CGFloat width = self.unlockBackgroundView.bounds.size.width - 2 * _distance;
        CGFloat height = self.unlockBackgroundView.bounds.size.height - _distance;
        _buttonView = [[CHKButtonView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _buttonView.radiusPaddingWidth = 3;
        _buttonView.origin = CGPointMake(self.unlockBackgroundView.bounds.size.width / 2,self.unlockBackgroundView.bounds.size.height);
        _buttonView.buttonColor = [UIColor greenColor];
        _buttonView.delegate = self;
        [self.unlockBackgroundView addSubview:_buttonView];
    }
    
    return _buttonView;
}

-(UILabel *)finishedLabel {
    if (!_finishedLabel) {
        CGFloat selfHeight = self.frame.size.height;
        CGFloat selfWidth = self.frame.size.width;
        _finishedLabel = [[UILabel alloc] init];
        _finishedLabel.frame = CGRectMake(selfWidth / 2 - _unlockLayerHeight / 8, selfHeight - selfHeight * 1/10 + 5, _unlockLayerHeight / 4, _unlockLayerHeight / 4);
        _finishedLabel.text = @"F";
        _finishedLabel.textAlignment = NSTextAlignmentCenter;
        _finishedLabel.layer.cornerRadius = _finishedLabel.frame.size.width / 2;
        _finishedLabel.layer.masksToBounds = YES;
        [self addSubview:_finishedLabel];
    }
    return _finishedLabel;
}

-(CHKOutputLayer *)outputLayer {
    if (!_outputLayer) {
        CGFloat selfHeight = self.frame.size.height;
        CGFloat selfWidth = self.frame.size.width;
        _outputLayer = [[CHKOutputLayer alloc] init];
        _outputLayer.frame = CGRectMake(selfWidth / 2 - selfWidth / 2 * 3/4, selfHeight * 1/10, selfWidth * 3/4, selfWidth * 3/4 / 4);
//        [_outputLayer pushColor:[UIColor redColor]];
//        [_outputLayer pushColor:[UIColor greenColor]];
        _outputLayer.outputDelegate = self;
        [self.layer addSublayer:_outputLayer];
    }
    return _outputLayer;
}

-(UIButton *)deleteButton {
    if (!_deleteButton) {
        CGFloat selfHeight = self.frame.size.height;
        CGFloat selfWidth = self.frame.size.width;
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteColor:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.frame = CGRectMake(selfWidth - _unlockLayerWidth / 5 - 10, selfHeight - selfHeight * 1/10 + 5 + (_unlockLayerHeight / 4 - _unlockLayerHeight / 5) / 2, _unlockLayerWidth / 5, _unlockLayerHeight / 5);
        _deleteButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_deleteButton setTitleColor:[UIColor colorWithRed:0 green:122/255.0 blue:255/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self addSubview:_deleteButton];
    }
    return _deleteButton;
}


#pragma mark Delegate

-(void)CHKButtonViewDidBeginPress:(CHKButtonView *)buttonView{
    //NSLog(@"begin");
    _colorLayer.visible = YES;
    _isInside = NO;
}

-(void)CHKButtonViewDidPress:(CHKButtonView *)buttonView pressureValue:(CGFloat)pressure location:(CGPoint)location{
    // press has been finished
    if (_isInside == YES) {
        return;
    }
    self.pointerLayer.pressure = pressure;
    _isInside = [self locationIsInside:location targetView:_finishedLabel];
    if (_isInside) {
        // finish press
        _colorLayer.visible = NO;
       
        UIColor *color = [_colorLayer colorWithPressureValue:self.pointerLayer.pressure];
        [_outputLayer pushColor:color];
    }
    
}

-(void)CHKButtonViewDidEndPress:(CHKButtonView *)buttonView {
    _colorLayer.visible = NO;
    _isInside = NO;
}

-(void)CHKOutputLayer:(CHKOutputLayer *)layer DidPickAColor:(UIColor *)color {
    if ([_delegate respondsToSelector:@selector(CHKColorLockView:didPickAColor:)]) {
        [_delegate CHKColorLockView:self didPickAColor:color];
    }
}

-(void)CHKOutputLayerDidPickAllColor:(CHKOutputLayer *)layer colorArray:(NSArray *)colorArray {
    NSLog(@"output : %@",colorArray);
    if ([_delegate respondsToSelector:@selector(CHKColorLockView:didEndPickColors:)]) {
        [_delegate CHKColorLockView:self didEndPickColors:colorArray];
    }
    
    CHKColorPasswordManager *manager = [[CHKColorPasswordManager alloc] init];
    BOOL isCorrect = [manager verifyColorPassword:colorArray];
    if (isCorrect) {
        NSLog(@"yes");
        if ([_delegate respondsToSelector:@selector(CHKColorLockView:verifyColorPassword:)]) {
            [_delegate CHKColorLockView:self verifyColorPassword:YES];
        }
    }else {
        if ([_delegate respondsToSelector:@selector(CHKColorLockView:verifyColorPassword:)]) {
            [_delegate CHKColorLockView:self verifyColorPassword:NO];
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_outputLayer popAllColor];
    });
}

#pragma mark public
-(BOOL)setColorPassword:(NSArray<UIColor *> *)colorArray {
    CHKColorPasswordManager *manager = [[CHKColorPasswordManager alloc] init];
    return [manager saveColorPassword:colorArray];
}

-(BOOL)setColorArray:(NSArray<UIColor *> *)colorArray {
    return [_colorLayer setColors:colorArray];
}

#pragma mark selector
-(void)deleteColor:(id)sender {
    [_outputLayer popColor];
}

#pragma mark helper
-(BOOL)locationIsInside:(CGPoint)location targetView:(UIView *)view {
    CGRect r = view.frame;
    if (location.x >= r.origin.x && location.x <= r.origin.x + r.size.width) {
        if (location.y >= r.origin.y && location.y <= r.origin.y + r.size.height) {
            return YES;
        }
    }
    return NO;
}

@end
