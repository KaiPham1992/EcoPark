//
//  WalletCell.swift
//  EcoPark
//
//  Created by Henry on 11/5/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class WalletCell: BaseTableCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbDateTime: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
    }
    
    func displayData(isPlus: Bool, dateTime: String, price: Int, content: String) {
        
        isPlus == true ? (imgIcon.image = AppImage.imgUp) : (imgIcon.image = AppImage.imgDown)
        lbDateTime.text = dateTime
        let newPrice = price.description.formatNumber(type: ",")
        isPlus == true ? (lbPrice.text = "+ \(newPrice)") : (lbPrice.text = "- \(newPrice)")
        lbContent.text = content
    }
}
