//
//  Biometrics.swift
//  FalconMessenger
//
//  Created by Danila Zykin on 05.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

class Biometrics: NSObject {
  var title: String?
  
  override init() {
    super.init()
    self.title = selectBiometricsType()
  }
  
  fileprivate func selectBiometricsType() -> String {
    let biometricType = userDefaults.currentIntObjectState(for: userDefaults.biometricType)
    
    switch biometricType {
    case 0:
      return "Unlock with Passcode"
    case 1:
      return "Unlock with Touch ID"
    case 2:
      return "Unlock with Face ID"
    default: return ""
    }
  }
}
