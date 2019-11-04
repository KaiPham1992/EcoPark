//
//  BaseCollectionCell.swift
//  EcoPark
//
//  Created by Tu DV on 11/4/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionCell: UICollectionViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        clipsToBounds = true
    }
}
