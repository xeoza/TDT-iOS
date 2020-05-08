//
//  TimestampView.swift
//  TDT-project
//
//  Created by Roma Babajanyan on 05.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

class TimestampView: RevealableView {

  @IBOutlet var titleLabel: UILabel!

  override init(frame: CGRect) {
    super.init(frame: frame)

    titleLabel.textColor = ThemeManager.currentTheme().generalSubtitleColor
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
}
