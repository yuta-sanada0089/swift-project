//
//  GitHubClientError.swift
//  GitHub Search Repository
//
//  Created by 真田雄太 on 2018/02/25.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import Foundation

enum GitHubClientError: Error {
    // 通信に失敗
    case connectionError(Error)
    // レスポンスの解釈に失敗
    case responseParseError(Error)
    // APIからエラーレスポンスを受け取った
    case apiError(GitHubAPIError)
}
