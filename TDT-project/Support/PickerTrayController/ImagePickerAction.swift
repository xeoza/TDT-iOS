//
//  ImagePickerAction.swift
//  ImagePickerTrayController
//
//  Created by Danila Zykin on 10.03.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

public struct ImagePickerAction {
  
    public typealias Callback = (ImagePickerAction) -> ()
    
    public var title: String
    public var image: UIImage
    public var callback: Callback
    
    func call() {
      callback(self)
    }
    
}
