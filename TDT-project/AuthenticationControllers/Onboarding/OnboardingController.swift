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
    
    view.addSubview(onboardingContainerView)
    onboardingContainerView.frame = view.bounds
  }
  
  @objc func startMessagingDidTap () {
  }

}
