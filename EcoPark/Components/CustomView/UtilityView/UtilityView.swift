//
//  UtilityView.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class UtilityView: BaseViewXib {
    @IBOutlet weak var cvUtility: UICollectionView!
    
    var utilyties = [UtilityModel]() {
        didSet {
            cvUtility.reloadData()
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        configureCollection()
        
        utilyties = UtilityModel.toArray()
    }
}

extension UtilityView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configureCollection() {
        cvUtility.registerXibCell(UtilityViewCell.self)
        cvUtility.dataSource = self
        cvUtility.delegate = self
        
        if let layout = cvUtility.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return utilyties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvUtility.dequeueCell(UtilityViewCell.self, indexPath: indexPath)
        cell.utility = self.utilyties[indexPath.item]
        
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (cvUtility.frame.width - 20 ) / 4
        return CGSize(width: width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.utilyties[indexPath.item]
        item.isSelected = !item.isSelected
        
        self.cvUtility.reloadData()
    }
}