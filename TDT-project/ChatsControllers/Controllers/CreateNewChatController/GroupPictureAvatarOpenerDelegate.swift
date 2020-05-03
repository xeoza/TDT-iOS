//
//  GroupPictureAvatarOpenerDelegate.swift
//  TDT-project
//
//  Created by Roman Babajanyan on 03.05.2020.
//  Copyright © 2020 Roman Babajanyan. All rights reserved.
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
