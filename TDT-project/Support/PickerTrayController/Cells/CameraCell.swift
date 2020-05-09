//
//  CameraCell.swift
//  ImagePickerTrayController
//
//  Created by Danila Zykin on 10.03.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

class CameraCell: UICollectionViewCell {
    
    var cameraView: UIView? {
        willSet {
            cameraView?.removeFromSuperview()
        }
        didSet {
            if let cameraView = cameraView {
                contentView.addSubview(cameraView)
              setNeedsLayout()
            }
        }
    }
    
    var cameraOverlayView: UIView? {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cameraView?.frame = bounds
        cameraOverlayView?.frame = bounds
    }
    
}
