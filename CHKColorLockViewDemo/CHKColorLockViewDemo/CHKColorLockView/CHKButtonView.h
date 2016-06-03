//
//  CHKButtonView.h
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/5/26.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>


@protocol CHKButtonViewDelegate;

@interface CHKButtonView : UIView

/**
 *  button property
 */
@property (nonatomic,assign,setter=setOrigin:) CGPoint origin;

@property (nonatomic,assign) CGFloat radiusPaddingWidth;

@property (nonatomic,strong) UIColor *buttonColor;

@property (nonatomic,weak) id<CHKButtonViewDelegate> delegate;

@end


@protocol CHKButtonViewDelegate <NSObject>

@optional
-(void)CHKButtonViewDidTap:(CHKButtonView *)buttonView;

-(void)CHKButtonViewDidBeginPress:(CHKButtonView *)buttonView;

-(void)CHKButtonViewDidPress:(CHKButtonView *)buttonView pressureValue:(CGFloat)pressure location:(CGPoint)location;

-(void)CHKButtonViewDidEndPress:(CHKButtonView *)buttonView;

@end