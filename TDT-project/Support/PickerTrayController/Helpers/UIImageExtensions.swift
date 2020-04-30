//
//  UIImageExtensions.swift
//  ImagePickerTrayController
//
//  Created by Danila Zykin on 10.03.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init?(bundledName name: String) {
        let bundle = Bundle(for: ImagePickerTrayController.self)
        self.init(named: name, in: bundle, compatibleWith:nil)
    }
    
}
