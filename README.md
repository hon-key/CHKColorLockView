# CHKColorLockView
颜色解锁小工具

此工具是基于force touch的颜色解锁工具，可以自定义颜色面板和颜色密码，通过force touch获取颜色并解锁。

`这是获取颜色前`

![](https://github.com/hon-key/CHKColorLockView/blob/master/IMG_0302.jpg)

`这是获取颜色后`

![](https://github.com/hon-key/CHKColorLockView/blob/master/IMG_0303.jpg)

用法
====
####import and set protocol
```objective-c
#import "CHKColorLockView.h"

@interface ViewController () <CHKColorLockViewDelegate>
```
####Add to your view
```objective-c
    // 1.init
    CHKColorLockView *lockView = [[CHKColorLockView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    // 2.add delegate
    lockView.delegate = self;
    
    // 3.set color pad
    [lockView setColorArray:@[[UIColor redColor],[UIColor blackColor],[UIColor yellowColor],[UIColor purpleColor]]];
    
    // 4.set color password
    [lockView setColorPassword:@[[UIColor redColor],[UIColor purpleColor],[UIColor redColor],[UIColor redColor]]];
   
    // 5.add to your app
    [self.view addSubview:lockView];
```

####验证结果在这里
```objective-c

// do what you want to do
-(void)CHKColorLockView:(CHKColorLockView *)colorLockView verifyColorPassword:(BOOL)isCorrect {
    
    UIAlertController *con = [UIAlertController alertControllerWithTitle:isCorrect?@"正确":@"不正确" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [con addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:con animated:YES completion:nil];
}
```

####如果你想随时监听获取的颜色
```objective-c
-(void)CHKColorLockView:(CHKColorLockView *)colorLockView didPickAColor:(UIColor *)color {
    
    NSLog(@"%@",color);
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    for (int i = 0; i < 4; i++) {
       
        NSLog(@"%f",components[i]);
   
    }
}
```

####如果你想一并获取四个颜色
```objective-c
-(void)CHKColorLockView:(CHKColorLockView *)colorLockView didEndPickColors:(NSArray<UIColor *> *)array {
    
    for (UIColor *color in array) {
       
        NSLog(@"#####%@",color);
       
        const CGFloat *components = CGColorGetComponents(color.CGColor);
     
        for (int i = 0; i < 4; i++) {
       
            NSLog(@"%f",components[i]);
     
        }
  
    }
}
```

如何添加到工程
====
把CHKColorLockView的所有文件加入你的APP就OK

注意
====
Only use in iphone 6s and 6s plus and later device
