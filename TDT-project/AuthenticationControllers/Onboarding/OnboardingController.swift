//
//  OnboardingController.swift
//  TDT-project
//
//  Created by Danila Zykin on 19.02.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

class OnboardingController: UIViewController {

  let onboardingContainerView = OnboardingContainerView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.white
    view.addSubview(onboardingContainerView)
    onboardingContainerView.frame = view.bounds
    setColorsAccordingToTheme()
  }
  
  fileprivate func setColorsAccordingToTheme() {
    let theme = ThemeManager.currentTheme()
    ThemeManager.applyTheme(theme: theme)
    view.backgroundColor = ThemeManager.currentTheme().generalBackgroundColor
    onboardingContainerView.backgroundColor = view.backgroundColor
  }
  
  @objc func startMessagingDidTap () {
    let destination = AuthPhoneNumberController()
    navigationController?.pushViewController(destination, animated: true)
  }

}

