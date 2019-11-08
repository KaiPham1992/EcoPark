//
//  AppTextField.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//


import UIKit
import DropDown
protocol AppDropDownNoTitleDelegate: class {
    func didChangedValue(sender: AppDropDownNoTitle, item: Any)
}

class AppDropDownNoTitle: BaseViewXib {
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var vContain: UIView!
    
    let dropDown = DropDown()
    var selectedItem: Any?
    weak var delegateDropDown: AppDropDownNoTitleDelegate?
    
    var listItem = [Any]() {
        didSet {
            setUpDropDown()
            if let tag = listItem as? [TagEntity] {
                dropDown.dataSource = tag.map {$0.name&}
            }
            if let tag = listItem as? [VehicleTypeEntity] {
                dropDown.dataSource = tag.map {$0.name&.replacingOccurrences(of: "Xe", with: "")}
            }
//            if let tag = listItem as? [NationalEntity] {
//                dropDown.dataSource = tag.map {$0.name&}
//            }
        }
    }
    
    func setPlaceHolder( placeHolder: String? = nil) {
      
        if placeHolder != nil {
            self.tfInput.placeholder = placeHolder
            self.tfInput.text?.removeAll()
//            tfInput.placeHolderColor = .black
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        
    }
    
    @IBAction func btnActionTapped() {
        dropDown.width = vContain.frame.width
        dropDown.show()
    }
    
    func setUpDropDown() {
        dropDown.anchorView = tfInput
        dropDown.backgroundColor = .white
        dropDown.width = vContain.frame.width
        
        dropDown.cellNib = UINib(nibName: "AppDropDownCell", bundle:  nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                        guard let cell = cell as? AppDropDownCell else { return }
            
            cell.lbContent.text = item
            return
        }
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfInput.text = item

            self.selectedItem = self.listItem[index]
            self.delegateDropDown?.didChangedValue(sender: self, item: self.selectedItem)
        }
    }
}
