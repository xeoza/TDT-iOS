//
//  ChangePhoneNumberController.swift
//  TDT-project
//
//  Created by Danila Zykin on 05.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit


class ChangePhoneNumberController: EnterPhoneNumberController {
  
  override func configurePhoneNumberContainerView() {
    super.configurePhoneNumberContainerView()
    
    let leftBarButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(leftBarButtonDidTap))
    navigationItem.leftBarButtonItem = leftBarButton
    phoneNumberContainerView.instructions.text = "Please confirm your country code\nand enter your NEW phone number."
		let attributes = [NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().generalSubtitleColor]
    phoneNumberContainerView.phoneNumber.attributedPlaceholder = NSAttributedString(string: "New phone number", attributes: attributes)
  }
  
  override func rightBarButtonDidTap() {
    super.rightBarButtonDidTap()
    
    let destination = ChangeNumberVerificationController()
    destination.enterVerificationContainerView.titleNumber.text = phoneNumberContainerView.countryCode.text! + phoneNumberContainerView.phoneNumber.text!
    navigationController?.pushViewController(destination, animated: true)
  }
}
