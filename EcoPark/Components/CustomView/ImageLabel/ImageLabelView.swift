//
//  ImageLabelView.swift
//  EcoPark
//
//  Created by Steve on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ImageLabelView : BaseViewXib {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func setUpViews() {
        
    }
    
    func initView(image: UIImage, title: String) {
        self.image.image = image
        self.lblTitle.text = title
    }
}
