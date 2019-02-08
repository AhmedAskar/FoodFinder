//
//  JSONParse.swift
//  FoodFinder
//
//  Created by Ahmed Askar on 2/6/19.
//  Copyright © 2019 Ahmed Askar. All rights reserved.
//

import Foundation

class JSONParse {
    
    enum ParseError: Error {
        case fileNotFound
        case errorWhileParsing
    }
    
    static func parseJson<T: Codable>(_ fileName: String) throws -> T {
        
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            throw ParseError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw error
        }
    }
}
