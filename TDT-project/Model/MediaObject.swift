//
//  MediaObject.swift
//  TDT-project
//
//  Created by Danila Zykin on 30.04.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit
import Photos

/// And object that represents instance of meida files such as photos, videos & audio
class MediaObject: NSObject {
	
  /// Data representation of media object
  var object: Data?
	
  /// Representation of video object
  var videoObject: Data?

  /// Representation of audio object
  var audioObject: Data?

  /// Media object indexPath
  var indexPath: IndexPath?

  /// String representing image source
  var imageSource: String?

  /// PHAsset of the object
  var phAsset: PHAsset?

  /// Media object file name
  var filename: String?

  /// Media object file url
  var fileURL: String?
  
  /// Default init
  /// - Parameter dictionary: pass a dictionary to initialize required variables of the instance that about to be created
  init(dictionary: [String: AnyObject]) {
    super.init()
    
    object = dictionary["object"] as? Data
    videoObject = dictionary["videoObject"] as? Data
    audioObject = dictionary["audioObject"] as? Data
    indexPath = dictionary["indexPath"] as? IndexPath
    imageSource = dictionary["imageSource"] as? String
    phAsset = dictionary["phAsset"] as? PHAsset
    filename = dictionary["filename"] as? String
    fileURL = dictionary["fileURL"] as? String
  }
}
