//
//  GroupPictureAvatarOpenerDelegate.swift
//  TDT-project
//
//  Created by Danila Zykin on 06.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

extension GroupProfileTableViewController: AvatarOpenerDelegate {
  func avatarOpener(avatarPickerDidPick image: UIImage) {
    groupProfileTableHeaderContainer.profileImageView.image = image
  }
  
  func avatarOpener(didPerformDeletionAction: Bool) {
    groupProfileTableHeaderContainer.profileImageView.image = nil
  }
}
