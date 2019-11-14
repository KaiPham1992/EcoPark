//
//  HomeFindCell.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import DropDown

class HomeFindCell: BaseTableCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbAddress: UILabel!

    var location = GoogleLocationEntity() {
        didSet {
            self.lbTitle.text = self.location.getPlaceName()
            self.lbAddress.text = self.location.getPlaceAddress()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
        
}
