//
//  SwitchObject.swift
//  TDT-project
//
//  Created by Danila Zykin on 05.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

class SwitchObject: NSObject {
  var title: String?
  var subtitle: String?
  
  var state: Bool! {
    didSet {
      guard defaultsKey != nil else { return }
      userDefaults.updateObject(for: defaultsKey, with: state)
    }
  }
  var defaultsKey:String!
  
  init(_ title: String?, subtitle: String?, state: Bool,defaultsKey: String ) {
    super.init()
    self.title = title
    self.subtitle = subtitle
    self.state = state
    self.defaultsKey = defaultsKey
  }
}
