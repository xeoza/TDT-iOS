//
//  LeaveGroupAndChangeAdminController.swift
//  TDT-project
//
//  Created by Danila Zykin on 06.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

class LeaveGroupAndChangeAdminController: SelectNewAdminTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupRightBarButton(with: "Leave the group")
  }
  
  override func rightBarButtonTapped() {
    super.rightBarButtonTapped()
    leaveTheGroupAndSetAdmin()
  }
}
