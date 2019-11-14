//
//  EmailValidator.swift
//  gofix-worker-ios
//
//  Created by Eric on 10/2/19.
//  Copyright © 2019 Vinova Pte. Ltd. All rights reserved.
//

import Foundation

struct EmailValidator: ValidatorProtocol {
    
    
    func validate(value: String) throws -> String {
        let regex = try NSRegularExpression(pattern: RegExr.email.pattern, options: [])
        
        if regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
            throw InvalidError(message: "EMAIL")
        }
        
        return value
    }

}
