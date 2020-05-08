//
//  ChangeGroupAdminController.swift
//  TDT-project
//
//  Created by Danila Zykin on 06.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

class ChangeGroupAdminController: SelectNewAdminTableViewController {
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setupRightBarButton(with: "Change administrator")
  }
  
  override func rightBarButtonTapped() {
    super.rightBarButtonTapped()
    setNewAdmin(membersIDs: getMembersIDs())
  }
}
