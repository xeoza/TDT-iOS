//
//  GeneralTabBarController.swift
//  TDT-project
//
//  Created by Danila Zykin on 19.02.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

enum Tabs: Int {
  case contacts = 0
  case chats = 1
  case settings = 2
}

class GeneralTabBarController: UITabBarController {

  let splashContainer: SplashScreenContainer = {
    let splashContainer = SplashScreenContainer()
    splashContainer.translatesAutoresizingMaskIntoConstraints = false
    return splashContainer
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureTabBar()
  }

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

  fileprivate func configureTabBar() {
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().generalSubtitleColor], for: .normal)
	tabBar.unselectedItemTintColor = ThemeManager.currentTheme().generalSubtitleColor
    tabBar.isTranslucent = false
    tabBar.layer.borderWidth = 0.50
    tabBar.layer.borderColor = UIColor.clear.cgColor
    tabBar.clipsToBounds = true
    setTabs()
  }

  //MARK: - TabBarController set up

  let chatsController = ChatsTableViewController()
  let contactsController = ContactsController()
  let settingsController = AccountSettingsController()

  fileprivate func setTabs() {
    
    contactsController.title = "Contacts"
    chatsController.title = "Chats"
    settingsController.title = "Settings"
    
    let contactsNavigationController = UINavigationController(rootViewController: contactsController)
    let chatsNavigationController = UINavigationController(rootViewController: chatsController)
    let settingsNavigationController = UINavigationController(rootViewController: settingsController)
    
    if #available(iOS 11.0, *) {
      settingsNavigationController.navigationBar.prefersLargeTitles = true
      chatsNavigationController.navigationBar.prefersLargeTitles = true
      contactsNavigationController.navigationBar.prefersLargeTitles = true
    }
    
    let contactsImage =  UIImage(named: "user")
    let chatsImage = UIImage(named: "chat")
    let settingsImage = UIImage(named: "settings")
    
    let contactsTabItem = UITabBarItem(title: contactsController.title, image: contactsImage, selectedImage: nil)
    let chatsTabItem = UITabBarItem(title: chatsController.title, image: chatsImage, selectedImage: nil)
    let settingsTabItem = UITabBarItem(title: settingsController.title, image: settingsImage, selectedImage: nil)
    
    contactsController.tabBarItem = contactsTabItem
    chatsController.tabBarItem = chatsTabItem
    settingsController.tabBarItem = settingsTabItem
    
    let tabBarControllers = [contactsNavigationController, chatsNavigationController as UIViewController, settingsNavigationController]
    viewControllers = tabBarControllers
    selectedIndex = Tabs.chats.rawValue
  }
}
