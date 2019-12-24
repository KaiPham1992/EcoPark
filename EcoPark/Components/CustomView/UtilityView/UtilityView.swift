//
//  UtilityView.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

protocol UtilityViewDelegate: class {
    func didSelect()
}

class UtilityView: BaseViewXib {
    @IBOutlet weak var cvUtility: UICollectionView!
    
    weak var delegate: UtilityViewDelegate?
    
    var utilyties = [MaterialEntity]() {
        didSet {
            cvUtility.reloadData()
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        configureCollection()
    }
    
//    func setMaterial(listMaterial: [MaterialEntity]) {
//        self.utilyties = UtilityModel.setMaterial(listMaterilType: listMaterial)
//    }
//
//    func setMaterial(listMaterialEntity: [MaterialEntity]) {
//        let filterList = listMaterialEntity.filter{ $0.is_active == "1"}
//        let listType = filterList.map { $0.type }
//        self.utilyties = UtilityModel.setMaterial(listMaterilType: listType as! [UtilityModelType])
//
//
//    }
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
        item.is_active = item.is_active == "1" ? "0": "1"
        delegate?.didSelect()
        
        self.cvUtility.reloadData()
    }
}
