//
//  OnboardingContainerView.swift
//  TDT-project
//
//  Created by Danila Zykin on 19.02.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

class OnboardingContainerView: UIView {

  let logoImageView: UIImageView = {
    let logoImageView = UIImageView()
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.image = UIImage(named: "roundedTDT")
    logoImageView.contentMode = .scaleAspectFit
    return logoImageView
  }()
  
  let welcomeTitle: UILabel = {
    let welcomeTitle = UILabel()
    welcomeTitle.translatesAutoresizingMaskIntoConstraints = false
    welcomeTitle.text = "Welcome to TDT"
    welcomeTitle.font = UIFont.systemFont(ofSize: 20)
    welcomeTitle.textAlignment = .center
    return welcomeTitle
  }()
  
  let startMessaging: UIButton = {
    let startMessaging = UIButton()
    startMessaging.translatesAutoresizingMaskIntoConstraints = false
    startMessaging.setTitle("Start messaging", for: .normal)
    startMessaging.titleLabel?.backgroundColor = .clear
    startMessaging.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    startMessaging.addTarget(self, action: #selector(OnboardingController.startMessagingDidTap), for: .touchUpInside)
    
    return startMessaging
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(logoImageView)
    addSubview(welcomeTitle)
    addSubview(startMessaging)
    
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
      logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
      logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
      
      startMessaging.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      startMessaging.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      startMessaging.heightAnchor.constraint(equalToConstant: 50),
      
      welcomeTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      welcomeTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      welcomeTitle.heightAnchor.constraint(equalToConstant: 50),
      welcomeTitle.bottomAnchor.constraint(equalTo: startMessaging.topAnchor, constant: -10)
    ])
    
    if #available(iOS 11.0, *) {
       startMessaging.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
    } else {
       startMessaging.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
}
