//
//  JSONDecodeError.swift
//  GitHub Search Repository
//
//  Created by 真田雄太 on 2018/02/25.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import Foundation

enum JSONDecodeError: Error {
    case invalidFormat(json: Any)
    case missingValue(key: String, actualValue: Any?)
}
