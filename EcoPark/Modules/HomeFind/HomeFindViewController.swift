//
//  HomeFindViewController.swift
//  EnglishApp
//
//  Created Ngoc Duong on 10/26/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

protocol HomeFindViewControllerDelegate: class {
    func didSelectAddress()
}

class HomeFindViewController: BaseViewController, HomeFindViewProtocol {

	var presenter: HomeFindPresenterProtocol?
    
    @IBOutlet weak var vSearch: AppSeachBarRight!
    @IBOutlet weak var tbFind: UITableView!
    
    weak var delegate: HomeFindViewControllerDelegate?

	override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setTitleUI() {
        super.setTitleUI()
        
        vSearch.setTitleAndPlaceHolder(placeHolder: "Chọn điểm đến")
    }
    
    override func setUpViews() {
        super.setUpViews()
        vSearch.actionSearch = { text in
           
        }
        configureTable()
        
        self.presenter?.searchPlaceByString(text: "hang  ")
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addButtonTextToNavigation(title: "CHỌN ĐIỂM ĐẾN", style: .left, action: nil, textColor: AppColor.color_0_129_255, font: AppFont.fontBold18)
        
        addButtonTextToNavigation(title: "Huỷ tìm kiếm", style: .right, action: #selector(btnCancel), textColor: AppColor.color_0_129_255, font: AppFont.fontRegular15)
    }
    
    
    @objc func btnCancel() {
        self.pop()
    }

}

extension HomeFindViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func configureTable() {
        tbFind.registerXibFile(HomeFindCell.self)
        tbFind.registerXibFile(FindAroundMeCell.self)
        
        tbFind.dataSource = self
        tbFind.delegate = self
        tbFind.separatorStyle = .none
        tbFind.estimatedRowHeight = 80
        tbFind.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = tableView.dequeue(FindAroundMeCell.self, for: indexPath)
                   
            return cell
        }
        
        let cell = tableView.dequeue(HomeFindCell.self, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectAddress()
        self.pop()
    }
}
