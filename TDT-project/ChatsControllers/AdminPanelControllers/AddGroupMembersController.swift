//
//  AddGroupMembersController.swift
//  TDT-project
//
//  Created by Danila Zykin on 06.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

class AddGroupMembersController: SelectParticipantsViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupRightBarButton(with: "Add")
    setupNavigationItemTitle(title: "Add users")
  }
  
  override func rightBarButtonTapped() {
    super.rightBarButtonTapped()
    
    addNewMembers()
  }
}
