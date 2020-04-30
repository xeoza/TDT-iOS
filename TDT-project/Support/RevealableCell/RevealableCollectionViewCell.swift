//
//  RevealableCollectionViewCell
//  RevealableCell
//
//  Created by Danila Zykin on 10.03.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

open class RevealableCollectionViewCell: UICollectionViewCell {
    
  var revealView: RevealableView?
    
  open override var isSelected: Bool {
      didSet {
          revealView?.isSelected = isSelected
      }
  }
  
  open override var isHighlighted: Bool {
    didSet {
      revealView?.isHighlighted = isHighlighted
    }
  }
    
  /**
   Ensure you call super.prepareForReuse() when overriding this method in your subclasses!
   */
  open override func prepareForReuse() {
    super.prepareForReuse()
  
    if let view = revealView {
      view.prepareForReuse()
    }
  }
  
}
