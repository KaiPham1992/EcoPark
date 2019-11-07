//
//  HistoryPartnerViewController.swift
//  EcoPark
//
//  Created Tu DV on 11/4/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class HistoryPartnerViewController: UIViewController, HistoryPartnerViewProtocol {

	var presenter: HistoryPartnerPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension HistoryPartnerViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Lịch sử")
    }
}