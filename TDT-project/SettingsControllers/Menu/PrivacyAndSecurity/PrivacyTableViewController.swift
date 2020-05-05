//
//  PrivacyTableViewController.swift
//  FalconMessenger
//
//  Created by Danila Zykin on 05.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit


private let privacyTableViewCellID = "PrivacyTableViewCellID"

class PrivacyTableViewController: SwitchTableViewController {
  
  var privacyElements = [SwitchObject]()


  override func viewDidLoad() {
      super.viewDidLoad()
    createDataSource()
    setTitle("Privacy")
    registerCell(for: privacyTableViewCellID)
  }
  
  fileprivate func createDataSource() {
    let biometricsState = userDefaults.currentBoolObjectState(for: userDefaults.biometricalAuth)
    let biometricsObject = SwitchObject(Biometrics().title, subtitle: nil, state: biometricsState, defaultsKey: userDefaults.biometricalAuth)
    privacyElements.append(biometricsObject)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return privacyElements.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: privacyTableViewCellID, for: indexPath) as? SwitchTableViewCell ?? SwitchTableViewCell()
    cell.currentViewController = self
    cell.setupCell(object: privacyElements[indexPath.row], index: indexPath.row)
   
    return cell
  }
}
