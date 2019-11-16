//
//  AppCollectionPhoto.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import ImagePicker

protocol AppCollectionPhotoDelegate: class {
    func appCollectionPhoto(_ collectionView: AppCollectionPhoto, changedHeight height: CGFloat)
    func appCollectionPhoto(_ collectionView: AppCollectionPhoto, selectedImages images: [UIImage])
    func removeImage(_ collectionView: AppCollectionPhoto, index: Int)
}

class AppCollectionPhoto: UIView {
    
    lazy var cvPhoto: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.isScrollEnabled = true
        //        layout.scrollDirection = .horizontal
        return cv
        
    }()
    
    weak var delegate: AppCollectionPhotoDelegate?
    weak var controller: UIViewController?
    var isSingleSelected = false
    var listIdDelete = [Int]() // use when edit
    
    var limit = 4
    
    var listImage = [UIImage]() {
        didSet {
            cvPhoto.reloadData()
            calculateHeight()
        }
    }
    //Layout Setting Variables
    var numberOfItemsPerRow: Int = 4
    var canEdit: Bool = true
    var deleteIcon: UIImage = AppImage.imgClose
    var addIcon: UIImage = AppImage.imgAddImage
    var cellBorderColor: UIColor = AppColor.gray999999
    var borderAll: Bool = true
    var ratioCell: CGFloat = 9/16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calculateHeight()
    }
    
    func setupView(){
        self.backgroundColor = UIColor.clear
        addSubview(cvPhoto)
        cvPhoto.fillSuperview()
        cvPhoto.registerCollectionCell(AppCollectionPhotoCell.self, fromNib: false)
    }
    
    func configCollectionImageView(delegate: AppCollectionPhotoDelegate?, controller: UIViewController?, isSingleSelected: Bool = false) {
        self.delegate = delegate
        self.controller = controller
        self.isSingleSelected = isSingleSelected
    }
    
    private func calculateHeight() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.delegate?.appCollectionPhoto(self, changedHeight: self.cvPhoto.contentSize.height)
        }
    }
}

extension AppCollectionPhoto: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if canEdit {
            if listImage.count <= 4 {
                return listImage.count + 1
            } else {
                return 5
            }
        } else {
            return 5//listImage.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(AppCollectionPhotoCell.self, indexPath: indexPath)
        cell.imgClose.isHidden = !canEdit || ( indexPath.item == 0 || isSingleSelected)
        cell.imgClose.image = deleteIcon
        if canEdit && indexPath.item == 0 {
            cell.imgPhoto.image = addIcon
            cell.imgPhoto.contentMode = .center
            cell.borderColor = cellBorderColor
        } else {
            let i = canEdit ? 1 : 0
            cell.imgPhoto.contentMode = .scaleToFill
            cell.photo = listImage[indexPath.item - i]
            if canEdit {
                cell.btnRemove.tag = indexPath.item - i
                cell.btnRemove.addTarget(self, action: #selector(btnRemoveTapped), for: .touchUpInside)
            }
            cell.borderColor = borderAll ? cellBorderColor : .clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width  / 2) - 16 //CGFloat(numberOfItemsPerRow)
        return CGSize(width: width, height: width) //* ratioCell)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if canEdit && indexPath.item == 0 {
            if listImage.count < 4 {
                showImagePicker()
            }
        }
    }
    
    @objc func btnRemoveTapped(sender: UIButton) {
        if sender.tag < listImage.count {
            self.listImage.remove(at: sender.tag)
            self.cvPhoto.reloadData()
            delegate?.removeImage(self, index: sender.tag)
        }
        
    }
}

extension AppCollectionPhoto: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        self.receivedImages(imagePicker: imagePicker, images: images)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.receivedImages(imagePicker: imagePicker, images: images)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    private func receivedImages(imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        if isSingleSelected {
            self.listImage = images
        } else {
            if self.listImage.count < 4 {
                self.listImage.append(contentsOf: images)
            }
        }
        
        delegate?.appCollectionPhoto(self, selectedImages: images)
        
        self.cvPhoto.reloadData()
    }
    
    func showImagePicker() {
        guard let controller = controller else { return }
        let imagePickerController = ImagePickerController()
        if isSingleSelected {
            limit = 1
            imagePickerController.imageLimit = limit
        } else {
            switch listImage.count {
            case 1:
                limit = 3
            case 2:
                limit = 2
            case 3:
                limit = 1
            case 4:
                limit = 0
            default:
                limit = 4
            }
            
            imagePickerController.imageLimit = limit
        }
        
        imagePickerController.delegate = self
        controller.present(imagePickerController, animated: true, completion: nil)
    }
}
