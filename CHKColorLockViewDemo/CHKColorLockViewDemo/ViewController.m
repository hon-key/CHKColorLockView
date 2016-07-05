//
//  ViewController.m
//  CHKColorLockViewDemo
//
//  Created by 蔡弘基 on 16/6/3.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import "ViewController.h"
#import "CHKColorLockView.h"

@interface ViewController () <CHKColorLockViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1.init
    CHKColorLockView *lockView = [[CHKColorLockView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    // 2.add delegate
    lockView.delegate = self;
    
    // 3.set color pad
    [lockView setColorArray:@[[UIColor redColor],[UIColor blackColor],[UIColor yellowColor],[UIColor purpleColor]]];
    
    // 4.set color password
    [lockView setColorPassword:@[[UIColor redColor],[UIColor purpleColor],[UIColor redColor],[UIColor redColor]]];
    
    lockView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
   
    // 5.add to your app
    [self.view addSubview:lockView];
}

// do what you want to do
-(void)CHKColorLockView:(CHKColorLockView *)colorLockView verifyColorPassword:(BOOL)isCorrect {
    UIAlertController *con = [UIAlertController alertControllerWithTitle:isCorrect?@"正确":@"不正确" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [con addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:con animated:YES completion:nil];
}
-(void)CHKColorLockView:(CHKColorLockView *)colorLockView didPickAColor:(UIColor *)color {
    NSLog(@"%@",color);
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    for (int i = 0; i < 4; i++) {
        NSLog(@"%f",components[i]);
    }
}
-(void)CHKColorLockView:(CHKColorLockView *)colorLockView didEndPickColors:(NSArray<UIColor *> *)array {
    for (UIColor *color in array) {
        NSLog(@"#####%@",color);
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        for (int i = 0; i < 4; i++) {
            NSLog(@"%f",components[i]);
        }
    }
}

@end
