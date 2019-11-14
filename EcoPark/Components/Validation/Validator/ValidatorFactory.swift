//
//  ValidatorFactory.swift
//  gofix-worker-ios
//
//  Created by Eric on 10/2/19.
//  Copyright © 2019 Vinova Pte. Ltd. All rights reserved.
//

enum ValidatorType {
    case requiredField(message: String)
    case email
}

enum Validator {
    static func validateFor(type: ValidatorType) -> ValidatorProtocol {
        switch type {
        case .requiredField(let message):
            return RequiredFieldValidator(message: message)
        case .email:
            return EmailValidator()
        }
    }
}
