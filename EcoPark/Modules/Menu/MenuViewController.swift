//
//  MenuViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

protocol MenuViewControllerDelegate: class {
    
    func selected(item: MenuItem)
    func loginTapped()
    func signUpPartnerTapped()
}


class MenuViewController: UIViewController, MenuViewProtocol {
    @IBOutlet weak var tbMenu: UITableView!
    var presenter: MenuPresenterProtocol?
    weak var delegateController: MenuViewControllerDelegate?
    @IBOutlet weak var lbLogin: UILabel!
    @IBOutlet weak var lbDisplayname: UILabel!
    @IBOutlet weak var lbOwner: UILabel!
    @IBOutlet weak var vRegisterOwner: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var heightRegisterOwner: NSLayoutConstraint!
    @IBOutlet weak var lbLogout: UILabel!
    
    var totalUnread: Int = 0
    
    var itemSelected: MenuItem?
    
    var listMenuItem = [MenuItem]() {
        didSet {
            tbMenu.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listMenuItem = MenuItem.toArray()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listMenuItem.forEach { item in
            item.isSelected = false
        }
        listMenuItem = MenuItem.toArray()
        for item in listMenuItem {
            if item.title == self.itemSelected?.title {
                item.isSelected = true
            }
        }
        tbMenu.reloadData()
        setUserName()
//        setRegisterOwner()
        
        Provider.shared.notificationAPIService.getNotification(offset: 1, limit: 20, screen: "SYSTEM", success: { parent in
            
            if let number = parent?.totalUnread {
                self.totalUnread = number
            }
            
             self.tbMenu.reloadData()
        }) { error in
            
        }
    }
    
    func setUserName() {
        if UserDefaultHelper.shared.loginUserInfo == nil {
            // not login
            lbLogin.text = LocalizableKey.MenuLogin.showLanguage
            lbDisplayname.isHidden = true
            lbOwner.isHidden = true
            vRegisterOwner.isHidden = true
            imgAvatar.image = AppImage.iconUsername
        } else {
            lbLogin.text = LocalizableKey.MenuLogout.showLanguage
            lbDisplayname.isHidden = false
            imgAvatar.sd_setImage(with:  UserDefaultHelper.shared.loginUserInfo?.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
            lbDisplayname.text = UserDefaultHelper.shared.loginUserInfo?.nameShowUI
            
            // login owner
            if UserDefaultHelper.shared.loginUserInfo?.parkingID& != "" {
                lbOwner.isHidden = false
                vRegisterOwner.isHidden = true
                heightRegisterOwner.constant = 0
            } else {
                // LoggedIn user
                lbOwner.isHidden = true
                vRegisterOwner.isHidden = false
                heightRegisterOwner.constant = 100
            }
        }
    }
    
//    func setRegisterOwner() {
//        if UserDefaultHelper.shared.parkingID != "" || UserDefaultHelper.shared.loginUserInfo?.parkingID& != "" {
//            vRegisterOwner.isHidden = true
//            heightRegisterOwner.constant = 0
//        } else {
//            vRegisterOwner.isHidden = false
//            heightRegisterOwner.constant = 100
//        }
//    }
    
    @IBAction func btnLoginLogoutTapped() {
        // need login
        if UserDefaultHelper.shared.loginUserInfo == nil {
            delegateController?.loginTapped()
        } else {
            
            PopUpHelper.shared.showLogout(completionNo: {
                
            }) {
                ProgressView.shared.showProgressOnWindow()
                Provider.shared.userAPIService.logout(success: { _ in
                    ProgressView.shared.hide()
                    UserDefaultHelper.shared.clearUser()
                    AppRouter.shared.openHomeView()
                    
                }) { _ in
                    ProgressView.shared.hide()
                }
            }
        }
    }
    
    @IBAction func btnSignUpPartnerTapped() {
        delegateController?.signUpPartnerTapped()
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbMenu.delegate = self
        tbMenu.dataSource = self
        tbMenu.registerXibFile(MenuCell.self)
        tbMenu.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(MenuCell.self, for: indexPath)
        cell.menuItem = self.listMenuItem[indexPath.item]
        cell.btnLanguage.tag = indexPath.item
        cell.btnLanguage.addTarget(self, action: #selector(btnLanguageTapped), for: .touchUpInside)
        cell.totalUnread = self.totalUnread
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMenuItem.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemSelected = self.listMenuItem[indexPath.item]
        self.listMenuItem.forEach { item in
            item.isSelected = false
        }
        
        itemSelected.isSelected = true
        self.itemSelected = itemSelected
        
        delegateController?.selected(item: itemSelected)
        
        tbMenu.reloadData()
    }
    
    @objc func btnLanguageTapped() {
        LanguageHelper.changeLanguage()
        
        AppRouter.shared.openHomeView()
    }
}

