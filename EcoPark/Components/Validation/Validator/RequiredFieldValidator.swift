//
//  RequiredFieldValidator.swift
//  gofix-worker-ios
//
//  Created by Eric on 10/2/19.
//  Copyright © 2019 Vinova Pte. Ltd. All rights reserved.
//

struct RequiredFieldValidator: ValidatorProtocol {
    
    var message: String
    
    
    init(message: String) {
        self.message = message
    }
    
    func validate(value: String) throws -> String  {
        
        if value.isEmpty == true {
            throw InvalidError.init(message: message)
        }
        
        return value
        
    }
}
