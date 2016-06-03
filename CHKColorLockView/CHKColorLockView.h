//
//  CHKColorLockView.h
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/5/23.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHKColorLockViewDelegate;

@interface CHKColorLockView : UIView

@property (nonatomic,weak) id<CHKColorLockViewDelegate> delegate;
/**
 * set color password
 */
-(BOOL)setColorPassword:(NSArray<UIColor *> *)colorArray;
/**
 * set the color you want to show to user
 */
-(BOOL)setColorArray:(NSArray<UIColor *> *)colorArray;
@end


@protocol CHKColorLockViewDelegate <NSObject>

@optional
-(void)CHKColorLockView:(CHKColorLockView *)colorLockView didPickAColor:(UIColor *)color;

-(void)CHKColorLockView:(CHKColorLockView *)colorLockView didEndPickColors:(NSArray<UIColor *> *)array;

-(void)CHKColorLockView:(CHKColorLockView *)colorLockView verifyColorPassword:(BOOL)isCorrect;

@end
