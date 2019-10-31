//
//  AppImageSlide.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/25/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import Foundation
import ImageSlideshow
class AppImageSlide: BaseViewXib {
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var lbIndex: PaddingLabel!
    
    var listURLImage = [URL]()
    var currentPage: Int = 0
    
    var listItem = [Any]() {
        didSet {
            var listUrlTemp = [URL]()
            var imageSource: [SDWebImageSource] = []
            
            if let listImage = listItem as? [String] {
                imageSource = listImage.map { _url -> SDWebImageSource? in
                    if let url = URL(string: _url) {
                        listUrlTemp.append(url)
                        return SDWebImageSource(url: url, placeholder: AppImage.imgPlaceHolderImage)
                    }
                    return nil
                    }.compactMap{$0}
            }
            
            if imageSource.count > 0 {
                listURLImage = listUrlTemp
                imageSlideShow.setImageInputs(imageSource)
                lbIndex.text = "1/\(self.listItem.count)"
                imageSlideShow.isHidden = false
            } else {
                lbIndex.text = ""
                imageSlideShow.isHidden = true
            }
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        imageSlideShow.pageIndicator = nil
        imageSlideShow.slideshowInterval = 5
        imageSlideShow.contentScaleMode = .scaleAspectFit
        imageSlideShow.backgroundColor = UIColor.black
        
        imageSlideShow.activityIndicator = DefaultActivityIndicator()
        imageSlideShow.currentPageChanged = {[weak self] page in
            guard let strongSelf = self else { return }
            strongSelf.currentPage = page
            strongSelf.lbIndex.text = "\(page + 1)/\(strongSelf.listItem.count)"
        }
        lbIndex.textColor = .white
        lbIndex.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 12.5)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnImageTapped)))
    }
    
    @objc func btnImageTapped() {
        guard let topVC = UIApplication.topViewController() else { return }
        let vc = PreviewPhotoViewController.createModule(listBanner: self.listURLImage, currentPage: currentPage)
        
        topVC.present(controller: vc)
    }
    
    @IBAction func btnNextTapped() {
        if currentPage < self.listItem.count - 1 {
            currentPage += 1
        } else {
            currentPage = 0
        }
        self.imageSlideShow.setCurrentPage(currentPage, animated: true)
    }
    
    @IBAction func btnPreTapped() {
        if currentPage > 0 {
            currentPage -= 1
        } else {
            currentPage = 0
        }
        
        self.imageSlideShow.setCurrentPage(currentPage, animated: true)
    }
}



public class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    
    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    public override func sizeToFit() {
        super.sizeThatFits(intrinsicContentSize)
    }
}
