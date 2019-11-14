//
//  RegExr.swift
//  gofix-worker-ios
//
//  Created by Eric on 10/2/19.
//  Copyright © 2019 Vinova Pte. Ltd. All rights reserved.
//

enum RegExr {
    
    case email
    
    var pattern: String {
        switch self {
        case .email:
            return "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@" +
                "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\." +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+"
        }
    }
}
