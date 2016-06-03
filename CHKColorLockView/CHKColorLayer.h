//
//  CHKColorLayer.h
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/5/23.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CHKColorLayer : CALayer

/**
 *   color layer property
 */
@property (nonatomic,assign) CGFloat length;

@property (nonatomic,assign) UIColor *blockColor1;

@property (nonatomic,assign) UIColor *blockColor2;

@property (nonatomic,assign) UIColor *blockColor3;

@property (nonatomic,assign) UIColor *blockColor4;

@property (nonatomic,assign,setter=setVisible:) BOOL visible;

-(UIColor *)colorWithPressureValue:(CGFloat)pressureValue;

-(BOOL)setColors:(NSArray *)colorArray;





@end
