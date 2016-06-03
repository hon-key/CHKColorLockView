//
//  CHKColorPasswordManager.m
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/6/1.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import "CHKColorPasswordManager.h"

static NSString * const CHKColorPassowrd = @"colorPassword";

@interface CHKColorPasswordManager ()

@property (nonatomic,strong) NSMutableArray *password;

@end

@implementation CHKColorPasswordManager

-(instancetype)init {
    if (self = [super init]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _password = [defaults objectForKey:CHKColorPassowrd];
        if (_password == nil) {
            _password = [NSMutableArray new];
        }
    }
    return self;
}



-(NSArray *)colorPasswordArray {
    NSMutableArray *array = [NSMutableArray new];
    // data unarchive
    for (NSData *data in _password) {
        UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array addObject:color];
    }
    return [array copy];
    
}


-(BOOL)saveColorPassword:(NSArray *)array {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _password = [NSMutableArray new];
    if (![self isColorArray:array]) {
        return NO;
    }
    // data archive
    for (UIColor *color in array) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:color];
        [_password addObject:data];
    }
    [defaults setObject:_password forKey:CHKColorPassowrd];
    
    return YES;
}
-(BOOL)verifyColorPassword:(NSArray *)array {
    if (![self isColorArray:array]) {
        return NO;
    }
    NSArray *correctArray = self.colorPasswordArray;
    for (int i = 0; i < 4; i++) {
        UIColor *color = [array objectAtIndex:i];
        UIColor *correctColor = [correctArray objectAtIndex:i];
        if (!CGColorEqualToColor(color.CGColor, correctColor.CGColor)) {
            return NO;
        }
    }
    return YES;
}

-(BOOL)isColorArray:(NSArray *)array {
    if (array.count != 4) {
        return NO;
    }
    for (id object in array) {
        if (![object isKindOfClass:[UIColor class]]) {
            return NO;
        }
    }
    return YES;
}


@end
