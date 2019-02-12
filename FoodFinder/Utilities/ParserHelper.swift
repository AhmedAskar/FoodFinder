//
//  ParserHelper.swift
//  FoodFinder
//
//  Created by A.Askar on 2/6/19.
//  Copyright © 2019 A.Askar. All rights reserved.
//

import Foundation

protocol ParserHelperProtocol {
    static func parseJson<T: Codable>(_ fileName: String) throws -> T
}

class ParserHelper: ParserHelperProtocol {
    
    enum ParseError: Error {
        case fileNotFound
        case errorWhileParsing
    }

    static func parseJson<T: Codable>(_ fileName: String) throws -> T {

        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            throw ParseError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw ParseError.errorWhileParsing
        }
    }
}
