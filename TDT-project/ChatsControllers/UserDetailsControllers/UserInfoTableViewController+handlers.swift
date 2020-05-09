//
//  UserInfoTableViewController+handlers.swift
//  TDT-project
//
//  Created by Danila Zykin on 06.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit


extension UserInfoTableViewController {
  
 @objc func openPhoto() {

    let imageView = UIImageView()
    
	let attributedCaptionSummary = NSMutableAttributedString(string: user?.name ?? "" + "\n",
																													 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
																																				NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
  
  imageView.sd_setImage(with: URL(string: user!.photoURL!)) { (image, _, _, _) in
      let photo = INSPhoto(image: image, thumbnailImage: nil, messageUID: nil)
      photo.attributedTitle = attributedCaptionSummary
      
      let photos: [INSPhotoViewable] = [photo]
      
      let indexPath = IndexPath(row: 0, section: 0)
      let cell = self.tableView.cellForRow(at: indexPath) as? UserinfoHeaderTableViewCell ?? UserinfoHeaderTableViewCell()
      let currentPhoto = photos[indexPath.row]
      let galleryPreview = INSPhotosViewController(photos: photos, initialPhoto: currentPhoto, referenceView: cell.icon)
        
      galleryPreview.referenceViewForPhotoWhenDismissingHandler = {  photo in
          return cell.icon
      }
      galleryPreview.modalPresentationStyle = .overFullScreen
      galleryPreview.modalPresentationCapturesStatusBarAppearance = true
      self.present(galleryPreview, animated: true, completion: nil)
    }
  }
}
