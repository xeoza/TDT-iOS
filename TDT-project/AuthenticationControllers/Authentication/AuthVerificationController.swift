//
//  AuthVerificationController.swift
//  TDT-project
//
//  Created by Danila Zykin on 11.03.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit


class AuthVerificationController: EnterVerificationCodeController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setRightBarButton(with: "Next")
  }
  
  override func rightBarButtonDidTap() {
    super.rightBarButtonDidTap()
    authenticate()
  }
}
