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
    
    var star: [Int] = [] {
        didSet{
            print(star)
        }
    }
    
    override func setUpViews() {
        for i in 0...3 {
            listButtonStar[i].isSelected = false
        }
    }
    
    @IBAction func btnTapped(_ sender: UIButton) {
        if sender != listButtonStar[3] { setUnSelected(listButtonStar[3]) }
        changeStatus(sender)
        updateStar()
    }
    
    private func changeStatus(_ button: UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            button.backgroundColor = AppColor.color_0_129_255.withAlphaComponent(0.6)
        } else {
            button.backgroundColor = .white
        }
    }
    
    private func setUnSelected(_ button: UIButton) {
        button.isSelected = false
        button.backgroundColor = .white
    }
    
    private func updateStar() {
        if listButtonStar[3].isSelected {
            self.star = [3,4,5]
            setUnSelected(listButtonStar[0])
            setUnSelected(listButtonStar[1])
            setUnSelected(listButtonStar[2])
        } else {
            self.star = []
            if listButtonStar[0].isSelected {
                addStar(5)
            } else {
                removeStar(5)
            }
            
            if listButtonStar[1].isSelected {
                addStar(4)
            } else {
                removeStar(4)
            }
            
            if listButtonStar[2].isSelected {
                addStar(3)
            } else {
                removeStar(3)
            }
        }
        // Default
        if self.star == [] { self.star = [1,2,3,4,5]}
    }
    
    private func addStar(_ star: Int) {
        if !self.star.contains(star) {
            self.star.append(star)
        }
    }
    
    private func removeStar(_ star: Int) {
        if self.star.contains(star) {
            self.star.removeFirst(star)
        }
    }
}

