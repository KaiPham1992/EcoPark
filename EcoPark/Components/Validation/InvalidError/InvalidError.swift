//
//  InvalidError.swift
//  gofix-worker-ios
//
//  Created by Eric on 10/2/19.
//  Copyright © 2019 Vinova Pte. Ltd. All rights reserved.
//

struct InvalidError: Error {
    
    var message: String
    
    init(message: String) {
        self.message = message
    }
}
