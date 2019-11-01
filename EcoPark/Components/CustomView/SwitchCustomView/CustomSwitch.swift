//
//  CustomSwitch.swift
//  ProgressBar
//
//  Created by vinova on 6/28/18.
//  Copyright © 2018 vinova. All rights reserved.
//

import UIKit
protocol CustomSwitchDelegate:class {
    func showPopupConfirm()
    func turnOnMatching()
}
@IBDesignable final class CustomSwitch: UIControl {
    
    public var onTintColor: UIColor = UIColor(red: 64/255, green: 186/255, blue: 124/255, alpha: 1) {
        didSet {
            self.setupUI()
        }
    }

    public var offTintColor: UIColor = .lightGray {
        didSet {
            self.setupUI()
        }
    }
    
    public var superViewCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
        }
    }

    public var thumbTintColor: UIColor = .white {
        didSet {
            self.thumbView.backgroundColor = self.thumbTintColor
        }
    }
    
    public var thumbCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    public var thumbSize: CGSize = .zero {
        didSet {
            self.layoutSubviews()
        }
    }
    
    
    public var padding: CGFloat = 4.0 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    public var isMyProfile = false
    public var isOn = false {
        didSet {
            self.isAnimating = true
            
            UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.curveEaseOut, .beginFromCurrentState], animations: {
                self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
                self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
            }) { _ in
                self.isAnimating = false
                self.sendActions(for: UIControl.Event.valueChanged)
            }
        }
    }
    
    public var animationDuration: Double = 0.5
    
    
    fileprivate var thumbView = UIView(frame: .zero)
    
    fileprivate var onPoint: CGPoint = .zero
    
    fileprivate var offPoint: CGPoint = .zero
    
    fileprivate var isAnimating = false
    
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    fileprivate func setupUI() {
        self.clear()
        self.clipsToBounds = false
        self.thumbView.backgroundColor = self.thumbTintColor
        self.thumbView.isUserInteractionEnabled = false
        self.addSubview(self.thumbView)
    }
    weak var delegate: CustomSwitchDelegate?
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.size.height * self.superViewCornerRadius
        
        if !self.isAnimating {
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        }
        
        //thumb managment
        
        let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width: self.bounds.size.height - self.padding * 2, height: self.bounds.size.height - self.padding * 2)
        let yPostition = (self.bounds.size.height - thumbSize.height) / 2
        
        self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.padding, y: yPostition)
        self.offPoint = CGPoint(x: self.padding, y: yPostition)
        
        self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
        
        self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func animate() {
        if isMyProfile {
            if self.isOn {
                delegate?.showPopupConfirm()
            } else {
                self.isOn = !self.isOn
                delegate?.turnOnMatching()
            }
        } else {
            self.isOn = !self.isOn
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        self.animate()
        return true
    }
}
