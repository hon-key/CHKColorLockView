//
//  CHKColorPasswordManager.h
//  CHKColorLock
//
//  Created by 蔡弘基 on 16/6/1.
//  Copyright © 2016年 蔡弘基. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHKColorPasswordManager : NSObject

/**
 *  Manager property
 */
@property (nonatomic,strong,readonly)NSArray *colorPasswordArray;

-(BOOL)saveColorPassword:(NSArray *)array;

-(BOOL)verifyColorPassword:(NSArray *)array;


@end
