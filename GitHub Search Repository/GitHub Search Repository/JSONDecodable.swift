//
//  JSONDecodable.swift
//  GitHub Search Repository
//
//  Created by 真田雄太 on 2018/02/25.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    init(json: Any) throws
}
