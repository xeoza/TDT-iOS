//
//  GeneralTabBarController.swift
//  TDT-project
//
//  Created by Danila Zykin on 19.02.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit


class GeneralTabBarController: UITabBarController {
	
  let splashContainer: SplashScreenContainer = {
    let splashContainer = SplashScreenContainer()
    splashContainer.translatesAutoresizingMaskIntoConstraints = false
    return splashContainer
  }()
  
  
  func presentOnboardingController() {
    let destination = OnboardingController()
    let newNavigationController = UINavigationController(rootViewController: destination)
    newNavigationController.navigationBar.shadowImage = UIImage()
    newNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
    newNavigationController.modalTransitionStyle = .crossDissolve
    if #available(iOS 13.0, *) {
        newNavigationController.modalPresentationStyle = .fullScreen
    }
    present(newNavigationController, animated: false, completion: nil)
  }
}
