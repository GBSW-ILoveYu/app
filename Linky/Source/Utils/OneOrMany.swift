//
//  OneOrMany.swift
//  Linky
//
//  Created by 박성민 on 5/5/25.
//

import Foundation

enum OneOrMany<T: Decodable>: Decodable {
    case one(T)
    case many([T])
    
    //string도 배열형식으로 사용할수 있게 만들어주는 클로저
    var values: [T] {
        switch self{
        case .one(let value): return [value]
        case .many(let values): return values
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let many = try? container.decode([T].self){
            self = .many(many)
        } else if let one = try? container.decode(T.self){
            self = .one(one)
        } else {
            throw DecodingError.typeMismatch(
                OneOrMany.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Expected T or [T]"
                )
            )
        }
    }
}
