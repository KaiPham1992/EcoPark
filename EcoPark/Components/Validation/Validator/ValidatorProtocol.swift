//
//  ValidatorProtocol.swift
//  gofix-worker-ios
//
//  Created by Eric on 10/2/19.
//  Copyright © 2019 Vinova Pte. Ltd. All rights reserved.
//

protocol ValidatorProtocol {
    func validate(value: String) throws -> String
}
