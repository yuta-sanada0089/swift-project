//
//  GitHubRequest.swift
//  GitHub Search Repository
//
//  Created by 真田雄太 on 2018/02/25.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import Foundation

protocol GitHubRequest {
    associatedtype Response: JSONDecodable
    
    var baseURL: URL {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: Any? {get}
}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: true
        )
    
        switch method {
        case .get:
            let dictionary = parameters as? [String : Any]
            let queryItems = dictionary?.map { key, value in
                return URLQueryItem(
                    name: key,
                    value: String(describing: value))
            }
            components?.queryItems = queryItems
        default:
            fatalError("Unsupported method \(method)")
        }
    
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    func response(from data: Data, urlResponse: URLResponse) throws -> Response {
        //取得したデータをJSONに変換
        let json = try JSONSerialization.jsonObject(
            with: data, options: [])
        
        if case (200..<300)? =
            (URLResponse() as? HTTPURLResponse)?.statusCode {
            //JSONからモデルをインスタンス化
            return try Response(json: json)
        } else {
          //JSONからAPIエラーをインスタンス化
            throw try GitHubAPIError(json: json)
        }
    }
}
