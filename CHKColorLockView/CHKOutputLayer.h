//
//  CHKOutputLayer.h
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/5/31.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@protocol CHKOutputLayerDelegate;

@interface CHKOutputLayer : CALayer

/**
 *  output layer property
 */

@property (nonatomic,weak) id <CHKOutputLayerDelegate> outputDelegate;

-(void)pushColor:(UIColor *)color;
-(void)popColor;
-(void)popAllColor;



@end

@protocol CHKOutputLayerDelegate <NSObject>

@optional
-(void)CHKOutputLayerDidPickAllColor:(CHKOutputLayer *)layer colorArray:(NSArray *)colorArray;
-(void)CHKOutputLayer:(CHKOutputLayer *)layer DidPickAColor:(UIColor *)color;

@end