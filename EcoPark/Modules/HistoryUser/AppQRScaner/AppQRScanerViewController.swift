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
                //                               self.noticeOnlyText("Mã QRCODE này không hợp lệ")
                //                               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                //                                   self.startScan()
                //                               }
                print("Mã QRCODE này không hợp lệ")
                return
            }
            
            base64String = base64String.replacingOccurrences(of: "ENG#", with: "")
            base64String = base64String.replacingOccurrences(of: "#MA", with: "")
            
            let decodedString = base64String.fromBase64()
            
            guard let arrayString = decodedString?.split(separator: "#") else { return }
            let mapString = arrayString.map{$0.description}
            self.completionCode?(mapString)
            self.pop()
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
