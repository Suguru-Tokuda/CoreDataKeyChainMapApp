//
//  User.swift
//  UsersMap
//
//  Created by Suguru Tokuda on 11/22/23.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let name, userName, email, phone, website: String
    let address: Address
    let company: Company
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, website, address, company, userName = "username"
    }
}

struct Address: Decodable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

struct Geo: Decodable {
    let lat, lng: Double
    
    enum CodingKeys: CodingKey {
        case lat
        case lng
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = Double(try container.decode(String.self, forKey: .lat)) ?? 0
        self.lng = Double(try container.decode(String.self, forKey: .lng)) ?? 0
    }
}

struct Company: Decodable {
    let name, catchPhrase, bs: String
}
