//
//  BookingInfoViewController.swift
//  EnglishApp
//
//  Created Ngoc Duong on 10/29/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class BookingInfoViewController: BaseViewController, BookingInfoViewProtocol {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var ratingBar: AppRatingView!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbCapacity: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbPriceOneHour: UILabel!
    @IBOutlet weak var lbPriceEightHour: UILabel!
    @IBOutlet weak var lbPriceToHoldPlace: UILabel!
    @IBOutlet weak var datePicker: DatePicker!
    @IBOutlet weak var timePicker: TimePicker!
    
	var presenter: BookingInfoPresenterProtocol?
    var parking: ParkingEntity?

	override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addBackToNavigation()
        setTitleNavigation(title: "Đặt giữ chỗ")
    }
    
    @IBAction func btnBookingTapped() {
        print(datePicker.tfDate.text)
        print(timePicker.tfTime.text)
        let pop = BookingPopUp()
        pop.showPopUp(address: "Address", message: "10", completionDirection: {
            print("Direction")
        }) {
            print("Detail")
        }
    }

}
