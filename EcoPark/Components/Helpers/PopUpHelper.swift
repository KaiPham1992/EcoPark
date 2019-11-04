//
//  PopUpHelper.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class PopUpHelper {
    
    static let shared = PopUpHelper()
    
    
    func showYesNo(message: String, completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        popUp.showPopUp(message: message, completionNo: completionNo, completionYes: completionYes)
    }
    
    func showUpdateFeature(completeUpdate: CompletionClosure?,completeCancel: CompletionClosure?){
        let popup = UpdateFeaturePopUp()
        popup.showPopUp(completeUpdate: completeUpdate, completeCancel: completeCancel)
    }
    
    func showComfirmPopUp(message: String,titleYes: String,titleNo: String,complete: CompletionClosure?){
        let popup = ConfirmPopUp()
        popup.showPopUp(message: message, titleYes: titleYes, titleNo: titleNo, complete: complete)
    }
    
    func showComfirmPopUp(message: String, titleYes: String, titleNo: String, height: Int = 180, complete: CompletionClosure?, cancel: CompletionClosure?){
        let popup = ConfirmPopUp()
        popup.showPopUp(message: message, titleYes: titleYes, titleNo: titleNo, height: height , complete: complete, cancel: cancel)
    }
    
    func showReportSuccessed(complete: CompletionClosure?){
        let popup = ReportSuccessedPopUp()
        popup.showPopUp(complete: complete)
    }
    
   
    func showReportQuestion(cancel: CompletionClosure?,report: CompletionMessage?){
        let popup = ReportQuestionPopUp()
        popup.showPopUp(cancel: cancel, report: report)
    }

    
    func showUpdateAccount(confirm: CompletionClosure?){
        let popup = UpdateAccountPopup()
        popup.showPopup(confirm: confirm)
    }
    
    
    func showLogout(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        
    popUp.vYesNoContentView.btnNo.setTitle(LocalizableKey.confirm.showLanguage.uppercased(), for: .normal)
    popUp.vYesNoContentView.btnYes.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        
        popUp.showPopUp(message: LocalizableKey.popUpLogout.showLanguage, completionNo: completionNo, completionYes: completionYes)
    }
    
    func showCreateGroup(completionNo: CompletionClosure?, completionYes: CompletionMessage?) {
        let popUp = CreateGroupPopUp()
        popUp.showPopUp(titlePopUp: LocalizableKey.createGroup.showLanguage,
                        titleInput: LocalizableKey.nameGroup.showLanguage,
                        placeHolderInput: LocalizableKey.enterNameGroup.showLanguage,
                        titleNo: LocalizableKey.cancel.showLanguage.uppercased(),
                        titleYes: LocalizableKey.createGroup.showLanguage.uppercased(),
                        completionNo: completionNo,
                        completionYes: completionYes)
    }
    
    func showLeaveGroup(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        popUp.vYesNoContentView.btnNo.setTitle(LocalizableKey.verifyButton.showLanguage.uppercased(), for: .normal)
        popUp.vYesNoContentView.btnYes.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        
        popUp.showPopUp(message: LocalizableKey.leaveTeamPopUp.showLanguage, completionNo: completionYes, completionYes: completionNo)
    }
    
    func showReport(completionNo: CompletionClosure?, completionYes: CompletionMessage?) {
        let popUp = CreateGroupPopUp()
        popUp.showPopUp(titlePopUp: LocalizableKey.createGroup.showLanguage,
                        titleInput: LocalizableKey.nameGroup.showLanguage,
                        placeHolderInput: LocalizableKey.enterNameGroup.showLanguage,
                        titleNo: LocalizableKey.cancel.showLanguage.uppercased(),
                        titleYes: LocalizableKey.createGroup.showLanguage.uppercased(),
                        completionNo: completionNo,
                        completionYes: completionYes)
    }
    
    func showThanks(completionYes: CompletionClosure?) {
        let popUp = ThanksReportPopUp()
        popUp.showPopUp(completionYes: completionYes)
    }
    
    func showNotEnoughtBee(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        popUp.vYesNoContentView.btnNo.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        popUp.vYesNoContentView.btnYes.setTitle(LocalizableKey.addBee.showLanguage.uppercased(), for: .normal)
        
        popUp.showPopUp(message: LocalizableKey.notEnoughBee.showLanguage, completionNo: completionNo, completionYes: completionYes)
    }
    
    func showNotEnoughtDiamon(completionYes: CompletionClosure?) {
        let popUp = NotificationPopUp()
        popUp.setButtonTitle(title: LocalizableKey.cancel.showLanguage.uppercased())
        
        popUp.showPopUp(message: LocalizableKey.notEnoughDiamon.showLanguage, completion: completionYes)
    }
    
    func showLeaveHomeWork(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        popUp.vYesNoContentView.btnNo.setTitle(LocalizableKey.verifyButton.showLanguage.uppercased(), for: .normal)
        popUp.vYesNoContentView.btnYes.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        
        popUp.showPopUp(message: LocalizableKey.popleaveHomeWork.showLanguage, completionNo: completionYes, completionYes: completionNo)
    }
    
    func showReward(diamond: Int, completionYes: CompletionClosure?) {
        let popUp = RewardPopUp()
        popUp.showPopup(diamond: diamond, completionYes: completionYes)
    }
    
    func showReward(message: String, completionYes: CompletionClosure?) {
        let popUp = RewardPopUp()
        popUp.showPopup(message: message, completionYes: completionYes)
    }
    
    func showLevelUp(completionYes: CompletionClosure?, completionPackage: CompletionClosure?) {
        let popUp = LevelUpPopUp()
        popUp.showPopUp(completionYes: completionYes, completionPackage: completionPackage)
    }
    
    func showChangePasswordSuccess(completionYes: CompletionClosure?) {
        let popUp = UpdateAccountPopup()
        popUp.showPopup(message: LocalizableKey.changePassswordSuccess.showLanguage, confirm: completionYes)
    }
    
    func showSignUpSuccess(completionYes: CompletionClosure?) {
        let popUp = UpdateAccountPopup()
        popUp.showPopup(message: LocalizableKey.signUpSuccess.showLanguage, confirm: completionYes)
    }
    
    func showEditProfile(completionYes: CompletionClosure?) {
        let popUp = UpdateAccountPopup()
        popUp.showPopup(message: LocalizableKey.editProfileSuccess.showLanguage, confirm: completionYes)
    }
    
    func showNoInternet(completionYes: CompletionClosure?) {
        let popUp = NotificationPopUp()
        popUp.showPopUp(message: LocalizableKey.pleaseTurnOnInternet.showLanguage, completion: completionYes)
    }
    
    func showError(message: String, completionYes: CompletionClosure?) {
        let popUp = NotificationPopUp()
        popUp.showPopUp(message: message, completion: completionYes)
    }
    
    func showErrorDidNotRemoveView(message: String, completionYes: CompletionClosure?) {
        let popUp = NotificationPopUp()
        popUp.showPopUp(message: message, completion: completionYes)
    }
    
    func sentNewPassword(completionYes: CompletionClosure?) {
        let popUp = UpdateAccountPopup()
        popUp.showPopup(message: "SENT_NEW_PASSWORD".showLanguage, confirm: completionYes)
    }
    
    func showNoAllowGifPhoto(completionYes: CompletionClosure?) {
        let popUp = NotificationPopUp()
        popUp.setButtonTitle(title: LocalizableKey.cancel.showLanguage.uppercased())
        popUp.showPopUp(message: LocalizableKey.notAllowGifPhoto.showLanguage, completion: completionYes)
    }
    
    
    // ---------------- EcoParking ------------------
    
    // MARK: Invalid QR
    func showInvalidQR(width: CGFloat = 350, height: CGFloat, completion: CompletionClosure?) {
        let popUp = OneButtonPopUp()
                
        let title = "Không hợp lệ"
        
        let blueAttr = [ NSAttributedString.Key.foregroundColor: UIColor.blue, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize),]
        let blackAttr = [ NSAttributedString.Key.foregroundColor: UIColor.black ]
        
        let string = "ECOPARKING"
        let attrString = NSAttributedString(string: string, attributes: blueAttr)
        
        
        let content1 = NSAttributedString(string: "Mã QR này không thuộc hệ thống ", attributes: blackAttr)
        let content2 = NSAttributedString(string: ".\nVui lòng đảm bảo bạn đã quét đúng thông tin!", attributes: blackAttr)
        
        let content = NSMutableAttributedString()
        content.append(content1)
        content.append(attrString)
        content.append(content2)
        
        let buttonTitle = "Thử lại"
        
        popUp.showPopUp(titlePopUp: title, contentPopUpAtributedString: content, buttonTitle: buttonTitle, width: width, height: height, completion: completion)
    }
    
    // MARK: Check in
    func showCheckIn(name: String, address: String, time: String, width: CGFloat, height: CGFloat, completionYes: CompletionClosure?, completionNo: CompletionClosure? ) {
        
        let popUp = CheckInPopUp()
        popUp.showPopUp(name: name, address: address, time: time, width: width, height: height, completionYes: completionYes, completionNo: completionNo)
    }
    
    // MARK: Cancel reservation
    func showCancelReservation(width: CGFloat, height: CGFloat = 215 , completionYes: CompletionClosure?, completionNo: CompletionClosure?) {
        
        let popUp = TwoButtonPopUp()
        popUp.showPopUp(titlePopUp: "HUỶ GIỮ CHỖ", contentPopUpNormal: "Bạn có chắc muốn huỷ giữ chỗ, chi phí đã thanh toán sẽ không được hoàn lại", btnTitleNo: "Quay lại", btnTitleYes: "Đồng ý", width: width, height: height, completionYes: completionYes, completionNo: completionNo)
    }
    
    // MARK: Extend reservation
    func showExtendReservation(width: CGFloat, height: CGFloat = 215, completionYes: CompletionClosure?, completionNo: CompletionClosure?) {
        
        let popUp = TwoButtonPopUp()
        popUp.showPopUp(titlePopUp: "GIA HẠN GIỮ CHỖ", contentPopUpNormal: "Gia hạn giữ chỗ sẽ có giá trị trong vòng 60 phút. \nVui lòng thanh toán thêm phí giữ chỗ", btnTitleNo: "Quay lại", btnTitleYes: "Thanh toán ví", width: width, height: height, completionYes: completionYes, completionNo: completionNo)
    }
    
    // MARK: No reservation
    func showNoReservation(width: CGFloat, height: CGFloat = 215, completionYes: CompletionClosure?, completionNo: CompletionClosure? ) {
        
        let popUp = TwoButtonPopUp()
        popUp.showPopUp(titlePopUp: "CHƯA CÓ ĐẶT CHỖ", contentPopUpNormal: "Bạn chưa đặt chỗ trước tại bãi đỗ này. Bạn có muốn bắt đầu giữ xe không?", btnTitleNo: "Không, cảm ơn", btnTitleYes: "Tiếp tục", width: width, height: height, completionYes: completionYes, completionNo: completionNo)
    }
    
    // MARK: Rating
    func showRating(width: CGFloat, height: CGFloat = 320, completionCancel: CompletionClosure?, completionSend: CompletionAny? ) {
        
        let popUp = RatingPopUp()
        popUp.showPopUp(width: width, height: height, completionCancel: completionCancel, completionSend: completionSend)
    }
    
    // MARK: Payment
    func showPayment(ecoMoney: Int, cashMoney: Int, needToPay: Int, width: CGFloat, height: CGFloat = 220, completionPay: CompletionClosure?) {
        
        let popUp = PaymentPopUp()
        popUp.showPopUp(ecoMoney: ecoMoney, cashMoney: cashMoney, needToPay: needToPay, width: width, height: height, completionPay: completionPay)
    }
    
    // MARK: Partner check out
    func showPartnerCheckOut(width: CGFloat, height: CGFloat = 330, price: Int, vehicleType: String, vehicleNumber: String, checkOutNumber: String, completionCancel: CompletionClosure?, completionCheckAgain: CompletionClosure?, completionCheckOut: CompletionClosure?) {
        
        let popUp = PartnerCheckOutPopUp()
        popUp.showPopUp(width: width, height: height, price: 320000, vehicleType: vehicleType, vehicleNumber: vehicleNumber, checkOutNumber: checkOutNumber, completionCancel: completionCancel, completionCheckAgain: completionCheckAgain, completionCheckout: completionCheckOut)
    }
}
