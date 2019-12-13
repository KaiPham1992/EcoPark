//
//  WebViewController.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/4/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewControllerDelegate: class {
    func goBack()
}

class WebViewController: BaseViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var mainUrl = "_api/webview/terms_of_use"
    
    var isTermCondition: Bool = false
    var isSignUp: Bool = false
    static func createModule(isTermCondition: Bool) -> WebViewController {
        let vc = WebViewController.initFromNib()
        vc.isTermCondition = isTermCondition
        
        return vc
    }
    
    
    override func setUpViews() {
        super.setUpViews()
//        loadData()
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        setTitleNavigation(title: LocalizableKey.privacyAndPolicy.showLanguage)
        if !isTermCondition {
            mainUrl = "_api/webview/security_policy"
            setTitleNavigation(title: LocalizableKey.security.showLanguage)
        }
        
        if LanguageHelper.currentAppleLanguage() == "en" {
            mainUrl = mainUrl + "/en"
        }
        
        guard let url = URL(string: BASE_URL + "\(mainUrl)") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        if isSignUp {
            addBackToNavigation()
        } else {
            addMenu()
        }
        
    }
}

extension WebViewController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
         let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        webView.evaluateJavaScript(jscript)
    }
}
