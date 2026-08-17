//
//  RoomCodeValidator.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/11/26.
//

import Foundation

enum RoomCodeValidationError: Error, Equatable {
    case empty
    case invalidLength
    case invalidCharacters
}

 struct RoomCodeValidator {
    static let requiredLength = 6
    
    //Capitalize and remove whitespaces for room code
    static func normalize(_ code: String) -> String {
        code
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
    }
 
    static func validate(_ code: String) throws -> String {
        //Capitalizes letters in code
        let normalizedCode = normalize(code)
        
        //Error if no code
        guard !normalizedCode.isEmpty else {
            throw RoomCodeValidationError.empty
        }
        
        //Error if code is too short
        guard normalizedCode.count == requiredLength else {
            throw RoomCodeValidationError.invalidLength
        }
        
        // Allow only uppercase letters and numbers
        let validCharacters = CharacterSet.uppercaseLetters.union(.decimalDigits)
        
        guard normalizedCode.unicodeScalars.allSatisfy({ validCharacters.contains($0) }) else {
            throw RoomCodeValidationError.invalidCharacters
        }
        
        return normalizedCode
    }
}
