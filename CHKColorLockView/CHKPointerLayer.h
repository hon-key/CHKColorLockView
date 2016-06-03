//
//  CHKPointerLayer.h
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/5/23.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CHKPointerLayer : CALayer

/**
 *   pointer property
 */
@property (nonatomic,assign,setter=setPressure:) CGFloat pressure;

@property (nonatomic,assign,readonly)CGPoint coordinate;

@property (nonatomic,strong) UIColor *pointerColor;

@property (nonatomic,assign) CGFloat distance;

-(instancetype)initWithFrame:(CGRect)frame;




@end
