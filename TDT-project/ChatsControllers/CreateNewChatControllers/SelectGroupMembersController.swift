//
//  SelectGroupMembersController.swift
//  TDT-project
//
//  Created by Danila Zykin on 06.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
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
