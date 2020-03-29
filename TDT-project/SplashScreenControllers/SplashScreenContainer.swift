//
//  SplashScreenContainer.swift
//  TDT-project
//
//  Created by Roman Babajanyan on 29/03/2020.
//  Copyright © 2020 Roman Babajanyan. All rights reserved.
//

import UIKit

class SplashScreenContainer: UIView {

  var navigationItem = UINavigationItem(title: AvatarOverlayTitle.user.rawValue)
  
  var viewForSatausbarSafeArea: UIView = {
    var viewForSatausbarSafeArea = UIView()
    viewForSatausbarSafeArea.translatesAutoresizingMaskIntoConstraints = false
    
    return viewForSatausbarSafeArea
  }()
  
  var navigationBar: UINavigationBar = {
    var navigationBar = UINavigationBar()
    navigationBar.translatesAutoresizingMaskIntoConstraints = false
    
    return navigationBar
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(navigationBar)
    addSubview(viewForSatausbarSafeArea)

    if #available(iOS 11.0, *) {
      navigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    } else {
      navigationBar.topAnchor.constraint(equalTo: topAnchor, constant:20).isActive = true
    }
    
    navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    navigationBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    viewForSatausbarSafeArea.topAnchor.constraint(equalTo: topAnchor).isActive = true
    viewForSatausbarSafeArea.bottomAnchor.constraint(equalTo: navigationBar.topAnchor).isActive = true
    viewForSatausbarSafeArea.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    viewForSatausbarSafeArea.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
}
