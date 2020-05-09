//
//  ChangeNumberVerificationController.swift
//  TDT-project
//
//  Created by Danila Zykin on 05.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit


class ChangeNumberVerificationController: EnterVerificationCodeController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setRightBarButton(with: "Confirm")
  }
  
  override func rightBarButtonDidTap() {
    super.rightBarButtonDidTap()
    changeNumber()
  }
}
