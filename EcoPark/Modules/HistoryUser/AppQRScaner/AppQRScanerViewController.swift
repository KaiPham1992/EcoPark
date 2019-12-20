//
//  AppQRScanerViewController.swift
//  EcoPark
//
//  Created by Ngoc Duong on 11/24/19.
//  Copyright © 2019 demo. All rights reserved.
//



import AVFoundation
import UIKit
import QRCodeReader

class AppQRScanerViewController: BaseViewController {
    @IBOutlet weak var previewView: QRCodeReaderView! {
        didSet {
            previewView.setupComponents(with: QRCodeReaderViewControllerBuilder {
                $0.reader                 = reader
                $0.showTorchButton        = false
                $0.showSwitchCameraButton = false
                $0.showCancelButton       = false
                $0.showOverlayView        = true
                $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
            })
        }
    }
    
    var isCheckIn: Bool = true
    
    static func createModule(isCheckIn: Bool) -> AppQRScanerViewController {
        let vc = AppQRScanerViewController.initFromNib()
        vc.isCheckIn = isCheckIn
        return vc
    }
    
    var completionCode: CompletionAny?
    
    lazy var reader: QRCodeReader = QRCodeReader()
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader                  = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton         = true
            $0.preferredStatusBarStyle = .lightContent
            $0.showOverlayView         = true
            $0.rectOfInterest          = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
            
            $0.reader.stopScanningWhenCodeIsFound = false
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    // MARK: - Actions
    
    private func checkScanPermissions() -> Bool {
        do {
            return try QRCodeReader.supportsMetadataObjectTypes()
        } catch let error as NSError {
            let alert: UIAlertController
            
            switch error.code {
            case -11852:
                alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.openURL(settingsURL)
                        }
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            default:
                alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }
            
            present(alert, animated: true, completion: nil)
            
            return false
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        if isCheckIn {
            setTitleNavigation(title: "Scan QR & Check in")
        } else {
            setTitleNavigation(title: "Scan QR & Check out")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard checkScanPermissions(), !reader.isRunning else { return }
        
        reader.didFindCode = {result in
            var base64String = result.value
            
            if !base64String.contains("ENG#") || !base64String.contains("#MA") {
                PopUpHelper.shared.showInvalidQR(height: 220, completion: {
                    self.reader.startScanning()
                })
                return
            }
            
            base64String = base64String.replacingOccurrences(of: "ENG#", with: "")
            base64String = base64String.replacingOccurrences(of: "#MA", with: "")
            
            let decodedString = base64String.fromBase64()
            
            guard let arrayString = decodedString?.split(separator: "#") else { return }
            let mapString = arrayString.map{$0.description}
            //-----
            
            if self.isCheckIn {
                let qrcode = mapString
                if qrcode.count > 2 {
                    ProgressView.shared.show()
                    // check QR
                    Provider.shared.userAPIService.scanQRCheckIn(parkingId: qrcode[2], bossParkingId: qrcode[1], success: { bookingDetail in
                        
//                        ProgressView.shared.hide()
                        guard let bookingDetail = bookingDetail, let time = bookingDetail.intend_checkin_time?.toString(dateFormat: AppDateFormat.ecoTime)& else { return }
                        
                        PopUpHelper.shared.showCheckIn(name: bookingDetail.fullname&, address: bookingDetail.address&, time: time, width: 350, height: 280, completionYes: {
                            
                            Provider.shared.bookingAPIService.checkIn(bookingId: bookingDetail.id&, success: { bookingResult in
                                //-- print checkin ok
                                self.reader.startScanning()
                                ProgressView.shared.hide()
                                let vc = DetailParkingRouter.createModule(bookingDetailEntity: bookingResult)
                                self.push(controller: vc)
                            }) { _ in
                                //-- error checkin
                                self.reader.startScanning()
                                 ProgressView.shared.hide()
                            }
                        }) {
                            //---
                            self.reader.startScanning()
                            ProgressView.shared.hide()
                        }
                        
                    }) { error in
                        ProgressView.shared.hide()
                        print("ERRRRRRRRRRRRRR")
                        PopUpHelper.shared.showNoReservation(width: 350, completionYes: {
                            self.reader.startScanning()
                            
//                            let vc = BookingInfoRouter.createModule(parking: ParkingEntity(id: qrcode[2]))
//                            self.push(controller: vc)
                            
                        }) {
//                            self.reader.startScanning()
                            self.pop()
                        }
                    }
                }
                else {
                    self.completionCode?(mapString)
                    self.pop()
                }
            }
            //-----
            
//            self.completionCode?(mapString)
           
        }
        
        reader.startScanning()
    }
    
}

extension AppQRScanerViewController {
    // MARK: - QRCodeReader Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true) { [weak self] in
            let alert = UIAlertController(
                title: "QRCodeReader",
                message: String (format:"%@ (of type %@)", result.value, result.metadataType),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        print("Switching capture to: \(newCaptureDevice.device.localizedName)")
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
}
