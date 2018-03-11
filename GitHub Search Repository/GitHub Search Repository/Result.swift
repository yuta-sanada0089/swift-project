//
//  Result.swift
//  GitHub Search Repository
//
//  Created by 真田雄太 on 2018/02/25.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import Foundation

enum Result<T, Error : Swift.Error> {
    case success(T)
    case failure(Error)
    
    init(value: T){
        self = .success(value)
    }
    
    init(error: Error){
        self = .failure(error)
    }
}
