//
//  customOverlayView.swift
//  SwiftyOnboard
//
//  Created by Jay on 3/26/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

public protocol SwiftyOnboardOverlayDelegate{
    
    func didClickContinue(_ onboardOverlay: SwiftyOnboardOverlay, button: UIButton)
    
    func didClickSkip(_ onboardOverlay: SwiftyOnboardOverlay, button: UIButton)
    
    func didClickSignin(_ onboardOverlay: SwiftyOnboardOverlay, button: UIButton)
}

open class SwiftyOnboardOverlay: UIView {

    public var delegate: SwiftyOnboardOverlayDelegate?
    

    public var logoView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    public var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        return pageControl
    }()
    
    public var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(didClickSignin(sender:)), for: .touchUpInside)
        return button
    }()
    
    public var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CONTINUE", for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(didClickContinue(sender:)), for: .touchUpInside)
        return button
    }()
    
    public var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(didClickSkip(sender:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
    
    func set(style: SwiftyOnboardStyle) {
        switch style {
        case .light:
            continueButton.setTitleColor(.white, for: .normal)
            skipButton.setTitleColor(.white, for: .normal)
            pageControl.currentPageIndicatorTintColor = UIColor.white
        case .dark:
            continueButton.setTitleColor(.black, for: .normal)
            skipButton.setTitleColor(.black, for: .normal)
            pageControl.currentPageIndicatorTintColor = UIColor.black
        }
    }
    
    public func page(count: Int) {
        pageControl.numberOfPages = count
    }
    
    public func currentPage(index: Int) {
        pageControl.currentPage = index
    }
    
    
    private let buttonHeightRatio: CGFloat = 0.07
    
    open override func layoutSubviews() {
        
        let height = self.frame.size.height * buttonHeightRatio
        continueButton.layer.cornerRadius = height/2
        continueButton.layer.borderColor = UIColor.white.cgColor
        continueButton.layer.borderWidth = 2
    }
    
    
    func setUp() {
        addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        logoView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        logoView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        logoView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        
        let resizableView = UIView()
        resizableView.isUserInteractionEnabled = false
        resizableView.isHidden = true
        addSubview(resizableView)
        resizableView.translatesAutoresizingMaskIntoConstraints = false
        resizableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        resizableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        resizableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        resizableView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        
        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.heightAnchor.constraint(equalToConstant: 15).isActive = true
        pageControl.topAnchor.constraint(equalTo: resizableView.bottomAnchor, constant: 10).isActive = true
        pageControl.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        pageControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: buttonHeightRatio).isActive = true
        continueButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        continueButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 10).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signInButton.widthAnchor.constraint(equalTo: continueButton.widthAnchor, multiplier: 1.0).isActive = true
        signInButton.heightAnchor.constraint(equalTo: continueButton.heightAnchor, multiplier: 1.0).isActive = true
        
        
        addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        skipButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        skipButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
    
    func didClickContinue(sender: UIButton){
        delegate?.didClickContinue(self, button: sender)
    }
    
    func didClickSignin(sender: UIButton){
        delegate?.didClickSignin(self, button: sender)
    }
    
    func didClickSkip(sender: UIButton){
        delegate?.didClickSkip(self, button: sender)
    }
}
