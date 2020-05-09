//
//  User.swift
//  TDT-project
//
//  Created by Danila Zykin on 30.04.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

/// An object that represents instance of s user
class User: NSObject {
  
  /// User id
  var id: String?

  /// User name
  @objc var name: String?

  /// String containing bio info about user
  var bio: String?

  /// User photo url
  var photoURL: String?

  /// Thumbnail photo url
  var thumbnailPhotoURL: String?
	
  /// User phone number
  var phoneNumber: String?

  /// Online status indication
  var onlineStatus: AnyObject?

  var isSelected: Bool! = false // local only
	
	/// Default init
	/// - Parameter dictionary: pass a dictionary to initialize required variables of the instance that about to be created
  init(dictionary: [String: AnyObject]) {
    id = dictionary["id"] as? String
    name = dictionary["name"] as? String
    bio = dictionary["bio"] as? String
    photoURL = dictionary["photoURL"] as? String
    thumbnailPhotoURL = dictionary["thumbnailPhotoURL"] as? String
    phoneNumber = dictionary["phoneNumber"] as? String
    onlineStatus = dictionary["OnlineStatus"]// as? AnyObject
  }
}

extension User { // local only
  var titleFirstLetter: String {
    guard let name = name else {return "" }
    return String(name[name.startIndex]).uppercased()
  }
}
