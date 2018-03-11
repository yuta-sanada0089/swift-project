//
//  Repository.swift
//  GitHub Search Repository
//
//  Created by 真田雄太 on 2018/02/25.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import Foundation

struct Repository: JSONDecodable {
    let id: Int
    let name: String
    let fullName: String
    let owner: User
    
    init(json: Any) throws {
        guard let dictionary = json as? [String: Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let id = dictionary["id"] as? Int else {
            throw JSONDecodeError.missingValue(
                key: "id", actualValue: ["id"])
        }
        
        
        guard let name = dictionary["name"] as? String else {
            throw JSONDecodeError.missingValue(
                key: "name", actualValue: ["name"])
        }
        
        guard let fullName = dictionary["full_name"] as? String else {
            throw JSONDecodeError.missingValue(
                key: "full_name", actualValue: ["full_name"])
        }
        
        guard let ownerObject = dictionary["owner"] else {
            throw JSONDecodeError.missingValue(
                key: "owner", actualValue: dictionary["owner"])
        }
        
        self.id = id
        self.name = name
        self.fullName = fullName
        self.owner = try User(json: ownerObject)
    }
}
