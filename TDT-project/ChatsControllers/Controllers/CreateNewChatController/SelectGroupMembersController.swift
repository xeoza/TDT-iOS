//
//  SelectGroupMembersController.swift
//  TDT-project
//
//  Created by Roman Babajanyan on 03.05.2020.
//  Copyright © 2020 Roman Babajanyan. All rights reserved.
//

import UIKit

class SelectGroupMembersController: SelectParticipantsViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		setupRightBarButton(with: "Next")
		setupNavigationItemTitle(title: "New group")
	}

	override func rightBarButtonTapped() {
		super.rightBarButtonTapped()

		createGroup()
	}
}
