//
//  FindAroundMeCell.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class FindAroundMeCell: BaseTableCell {
    @IBOutlet weak var lbNearMe: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addLineWhiteToBottom()
        
        lbNearMe.text = LocalizableKey.NearMe.showLanguage
    }
}
