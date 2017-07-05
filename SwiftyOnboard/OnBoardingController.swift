//
//  File.swift
//  SwiftyOnboard
//
//  Created by Antonio Zaitoun on 05/04/2017.
//  Copyright © 2017 Antonio Zaitoun. All rights reserved.
//

import Foundation
import UIKit

public class OnBoardingController: UIViewController{
    
    open var delegate: SwiftyOnboardDelegate?
    
    open var dataSource: SwiftyOnboardDataSource?
    
    var swiftyOnboard: SwiftyOnboard!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        swiftyOnboard = SwiftyOnboard(frame: view.frame, style: .light)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        swiftyOnboard.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        swiftyOnboard.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        swiftyOnboard.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        swiftyOnboard.dataSource = dataSource
        swiftyOnboard.delegate = delegate
    }
    
    open func make(in controller: UIViewController,animated: Bool = true, completion: (()->Void)? = nil){
        modalPresentationCapturesStatusBarAppearance = true
        controller.present(self, animated: animated, completion: completion)
    }
    
    override public var prefersStatusBarHidden: Bool{
        return true
    }
    
}
