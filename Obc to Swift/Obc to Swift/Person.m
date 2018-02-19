//
//  Person.m
//  Obc to Swift
//
//  Created by 真田雄太 on 2018/02/18.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

#import "Person.h"

@implementation Person

+(id)shredPerson {
    static Person *sharedPerson = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPerson = [self new];
    });
    return sharedPerson;
}

+(instancetype)sharedInstanceTypePerson{
    return [self shredPerson];
}

+(id)sharedIDPerson {
    return [self shredPerson];
}

@end
