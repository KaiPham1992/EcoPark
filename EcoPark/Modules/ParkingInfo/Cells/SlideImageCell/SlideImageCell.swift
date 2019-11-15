//
//  SlideImageCell.swift
//  EcoPark_Dev
//
//  Created by Tu DV on 11/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class SlideImageCell: UITableViewCell {

    @IBOutlet weak var vSlideImage: AppImageSlide!
    @IBOutlet weak var btnCamera: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(parkingInfo: ParkingInfoEntity?) {
        if let listImage = parkingInfo?.img?.map({ $0.imageURL }){
            vSlideImage.listItem = listImage as [Any]
        }
    }
}
