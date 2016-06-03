//
//  CHKCircularLayer.h
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/5/23.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CHKCircularLayer : CALayer

/**
 *   circlar property
 */
@property (nonatomic,strong) UIColor *backColor;

@property (nonatomic,assign) CGFloat distance;

@end
