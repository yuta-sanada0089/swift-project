//
//  ObjcClass.h
//  Obc to Swift
//
//  Created by 真田雄太 on 2018/02/18.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjcClass : NSObject

NS_ASSUME_NONNULL_BEGIN //囲まれた値は自動的にnonnullになる
- (NSString *)nonnullString;
- (NSString *)nonnullStringWithNullableString:
    (nullable NSString *)nullableString;
NS_ASSUME_NONNULL_END

@end
