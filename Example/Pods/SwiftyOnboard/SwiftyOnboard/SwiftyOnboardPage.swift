//
//  customPageView.swift
//  SwiftyOnboard
//
//  Created by Jay on 3/25/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

open class SwiftyOnboardPage: UIView {
    
    public var title: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    public var subTitle: UILabel = {
        let label = UILabel()
        label.text = "Sub Title"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    public var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func set(style: SwiftyOnboardStyle) {
        switch style {
        case .light:
            title.textColor = .white
            subTitle.textColor = .white
        case .dark:
            title.textColor = .black
            subTitle.textColor = .black
        }
    }
    
    func setUp() {
        
        let resizeableView = UIView()
        resizeableView.backgroundColor = .clear
        addSubview(resizeableView)
        
        resizeableView.translatesAutoresizingMaskIntoConstraints = false
        resizeableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        resizeableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        resizeableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        resizeableView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.18).isActive = true
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0).isActive = true
        imageView.topAnchor.constraint(equalTo: resizeableView.bottomAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        title.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        subTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 0).isActive = true
        //subTitle.heightAnchor.constraint(equalTo: title.heightAnchor).isActive = true
    }
}
