//
//  CreateProfileController+keyboardHandlers.swift
//  TDT-project
//
//  Created by Danila Zykin on 11.03.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

extension UIViewController {
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
