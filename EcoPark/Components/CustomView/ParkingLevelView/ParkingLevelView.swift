//
//  ParkingLevelView.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/28/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class ParkingLevelView: BaseViewXib {
    
    @IBOutlet var listButtonStar: [UIButton]!
    
    // Default value if user not choose any thing
    var star: [Int] = [1,2,3,4,5] {
        didSet{
            print(star)
        }
    }
    
    override func setUpViews() {
        for i in 0...3 {
            listButtonStar[i].isSelected = false
        }
    }
    
    @IBAction func btnFiveStarTapped() {
        star = [5]
        changeStatus(listButtonStar[0])
        setUnSelected(listButtonStar[3])
    }
    
    @IBAction func btnFourStarTapped() {
        star = [4]
        changeStatus(listButtonStar[1])
        setUnSelected(listButtonStar[3])
    }
    
    @IBAction func btnThreeStarTapped() {
        star = [3]
        changeStatus(listButtonStar[2])
        setUnSelected(listButtonStar[3])
    }
    
    @IBAction func btnAllStarTapped() {
        star = [1,2,3,4,5]
        changeStatus(listButtonStar[3])
        setUnSelected(listButtonStar[0])
        setUnSelected(listButtonStar[1])
        setUnSelected(listButtonStar[2])
    }
    
    private func changeStatus(_ button: UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            button.backgroundColor = AppColor.color_0_129_255.withAlphaComponent(0.6)
        } else {
            button.backgroundColor = .white
        }
    }
    
    func setUnSelected(_ button: UIButton) {
        button.isSelected = false
        button.backgroundColor = .white
    }
}

