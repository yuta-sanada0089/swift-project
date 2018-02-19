//
//  ObjcClass.m
//  Obc to Swift
//
//  Created by 真田雄太 on 2018/02/18.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

#import "ObjcClass.h"

@implementation ObjcClass

- (NSString *)nonnullString {
    return @"nonnull";
}

- (NSString *)nonnullStringWithNullableString:(NSString *)nullableString {
    return @"nonnull";
}

@end
