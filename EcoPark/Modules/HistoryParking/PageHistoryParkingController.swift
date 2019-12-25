//
//  PageHistoryParkingController.swift
//  EcoPark
//
//  Created by Steve on 11/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class PageHistoryParkingController : PageViewController {
    var idBookingCheckIn = ""
    var isHaveReserver: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleNavigation(title: LocalizableKey.history_parking.showLanguage)
        addButtonImageToNavigation(image: #imageLiteral(resourceName: "ic_menu"), style: StyleNavigation.left, action: #selector(openMenu))
//        addButtonImageToNavigation(image: #imageLiteral(resourceName: "ic_qrcheckin"), style: StyleNavigation.right, action: #selector(checkQrCode))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        checkIconCheckInCheckOut()
    }
    
    func checkIconCheckInCheckOut() {
        self.idBookingCheckIn = ""
        self.isHaveReserver = false
        
        Provider.shared.parkingAPIService.getDoingBooking(success: { array in
            
            for booking in array {
                if booking.status == "checked_in" {
                    self.idBookingCheckIn = booking.id&
                }
                
                if booking.status& == StatusBooking.reservation.rawValue {
                    self.isHaveReserver = true
                }
            }
            
            if self.idBookingCheckIn != "" {
                self.addButtonToNavigation(image: AppImage.iconCheckout, style: .right, action: #selector(self.btnCheckOut))
            } else {
                // have reserver
                if self.isHaveReserver {
                    self.addButtonToNavigation(image: AppImage.iconCheckin, style: .right, action: #selector(self.btnCheckIn))
                } else {
                    self.navigationController?.navigationItem.rightBarButtonItem = nil
                }
                
            }
        }) { error in
            
        }
    }
    
     @objc func btnCheckOut() {
            let vc = CheckOutRouter.createModule(bookingId: self.idBookingCheckIn)
            self.push(controller: vc)
        }
        
        @objc func btnCheckIn() {
            let vc = AppQRScanerViewController.createModule(isCheckIn: true)
            vc.completionCode = { qrcode in
                guard let qrcode = qrcode as? [String] else { return }
                if qrcode.count > 2 {
                    
                    ProgressView.shared.show()
                    
                    Provider.shared.userAPIService.scanQRCheckIn(parkingId: qrcode[2], bossParkingId: qrcode[1], success: { bookingDetail in
                        ProgressView.shared.hide()
                        guard let bookingDetail = bookingDetail else { return }
                        
                        PopUpHelper.shared.showCheckIn(name: bookingDetail.fullname&, address: "Địa Chỉ", time: "12/12", width: 350, height: 220, completionYes: {
                            //---
                        }) {
                            //---
                        }
                       
    //                    let vc = DetailParkingRouter.createModule(bookingDetailEntity: bookingDetail)
    //                    self.push(controller: vc)
                        
                    }) { error in
                        ProgressView.shared.hide()
                    }
                }
            }
            
            self.push(controller: vc)
        }
    
    @objc func openMenu(){
        if let containerController = navigationController?.parent as? ContainerViewController {
            containerController.toggleLeftPanel()
        }
    }
    
    func addButtonToNavigation(image: UIImage, style: StyleNavigation, action: Selector?) {
           showNavigation()
           let btn = UIButton()
           btn.setImage(image, for: .normal)
           if let newAction = action {
               btn.addTarget(self, action: newAction, for: .touchUpInside)
           }
           
           btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
           
           let button = UIBarButtonItem(customView: btn)
           if style == .left {
               btn.contentHorizontalAlignment = .left
               self.navigationItem.leftBarButtonItem = button
           } else {
               self.navigationItem.rightBarButtonItem = button
               btn.contentHorizontalAlignment = .right
           }
       }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [HistoryParkingRouter.createModule(type: TypeHistoryParking.doing), HistoryParkingRouter.createModule(type: TypeHistoryParking.history)]
    }
}
