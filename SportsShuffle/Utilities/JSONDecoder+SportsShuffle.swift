//
//  JSONDecoder+SportsShuffle.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/12/26.
//

import Foundation

extension JSONDecoder {
    static var sportsShuffle: JSONDecoder {
        JSONDecoder()
    }
    
    func decode<T: Decodable>(
        _ type: T.Type,
        from json: String
    ) throws -> T {
        let data = Data(json.utf8)
        return try decode(T.self, from: data)
    }
}
