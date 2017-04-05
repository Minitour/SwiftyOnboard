//
//  ViewController.swift
//  SwiftyOnboardExample
//
//  Created by Jay on 3/27/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit
import SwiftyOnboard

class ViewController: UIViewController {
    
    var swiftyOnboard: SwiftyOnboard!
    
    var titles: [String] = ["A marketplace of art","Everything goes","A better way to communicate"]
    var subtitles: [String] = ["Create, share & buy content","We support all types of media","Use your download content on IM apps"]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let onBoardingController = OnBoardingController()
        onBoardingController.delegate = self
        onBoardingController.dataSource = self
        onBoardingController.make(in: self)
    }
    
    
    
    func handleSkip() {
        swiftyOnboard?.goToPage(index: 2, animated: true)
    }
    
    func handleContinue(sender: UIButton) {
        let index = sender.tag
        swiftyOnboard?.goToPage(index: index + 1, animated: true)
    }
}

extension ViewController: SwiftyOnboardDelegate {
    func swiftyOnboard(_ swiftyOnboard: SwiftyOnboard, didClickContinue button: UIButton, atIndex index: Int,isLast: Bool) {
        if !isLast {
            swiftyOnboard.goToPage(index: index+1, animated: true)
        }
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = SwiftyOnboardPage()
        
        //Set the image on the page:
        view.imageView.image = UIImage(named: "onboard\(index)")
        
        //Set the font and color for the labels:
        view.title.font = UIFont(name: "Lato-Heavy", size: 22)
        view.subTitle.font = UIFont(name: "Lato-Regular", size: 16)
        view.title.text = titles[index]
        view.subTitle.text = subtitles[index]
        
        //Return the page for the given index:
        return view
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = Int(round(position))
        if currentPage < swiftyOnboard.pageCount - 1 {
            overlay.continueButton.setTitle("CONTINUE", for: .normal)
            overlay.skipButton.isHidden = true
        } else {
            overlay.continueButton.setTitle("REGISTER", for: .normal)
            overlay.skipButton.isHidden = false
        }
    }
}

extension ViewController: SwiftyOnboardDataSource{
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        //Number of pages in the onboarding:
        return 3
    }
    
    func swiftyOnboardBackgroundColorFor(_ swiftyOnboard: SwiftyOnboard, atIndex index: Int) -> UIColor? {
        let colors:[UIColor] = [#colorLiteral(red: 0.9980840087, green: 0.3723873496, blue: 0.4952875376, alpha: 1),#colorLiteral(red: 0.2666860223, green: 0.5116362572, blue: 1, alpha: 1),#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)]
        return colors[index]
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.continueButton.titleLabel?.font = UIFont(name: "Lato-Bold", size: 16)
        overlay.continueButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.titleLabel?.font = UIFont(name: "Lato-Heavy", size: 16)
        overlay.signInButton.setTitleColor(UIColor.white, for: .normal)
        overlay.signInButton.titleLabel?.font = UIFont(name: "Lato-Heavy", size: 16)
        overlay.logoView.image = #imageLiteral(resourceName: "space1")
        overlay.skipButton.isHidden = true
        
        //Return the overlay view:
        return overlay
    }
}


