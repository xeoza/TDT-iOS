//
//  Message.swift
//  TDT-project
//
//  Created by Danila Zykin on 30.04.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit
import Firebase

/// Struct for message subtitle
struct MessageSubtitle {
  static let video = "Attachment: Video"
  static let image = "Attachment: Image"
  static let audio = "Audio message"
  static let empty = "No messages here yet."
}

/// An object that represents a message instance
class Message: NSObject  {
  
    /// Unique Identifier of the message
    var messageUID: String?
	
    /// Indication wheather this is info message
    var isInformationMessage: Bool?
	
    /// Message sender Id
    var fromId: String?
	
    /// Text of the message
    var text: String?

    /// Message recipient Id
    var toId: String?

    /// Message timestamp (raw)
    var timestamp: NSNumber?

    /// Message timestamp (raw)
    var convertedTimestamp: String?

    /// String that represents staus of the message
    var status: String?
	
    /// Flag that determines wheather message was seen by recipient
    var seen: Bool?
  
    /// Url of image attachment
    var imageUrl: String?
    var imageHeight: NSNumber?
    var imageWidth: NSNumber?
  
    /// Local UIImage instance
    var localImage: UIImage?

    /// Urll of local video
    var localVideoUrl: String?
  
    /// Voicemessage Data
    var voiceData: Data?

    /// Voicemessage duration
    var voiceDuration: String?
    var voiceStartTime: Int?
    var voiceEncodedString: String?

    var videoUrl: String?
  
    var estimatedFrameForText:CGRect?
    var imageCellHeight: NSNumber?
  
    var senderName: String? //local only, group messages only
	
	/// Returns id of chat participant only, not for group chats
	/// - Returns: id of chat participant
    func chatPartnerId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
	
	/// Default init
	/// - Parameter dictionary: pass a dictionary to initialize required variables of the instance that about to be created
    init(dictionary: [String: AnyObject]) {
        super.init()
      
        messageUID = dictionary["messageUID"] as? String
        isInformationMessage = dictionary["isInformationMessage"] as? Bool
        fromId = dictionary["fromId"] as? String
        text = dictionary["text"] as? String
        toId = dictionary["toId"] as? String
        timestamp = dictionary["timestamp"] as? NSNumber
      
        convertedTimestamp = dictionary["convertedTimestamp"] as? String
      
        status = dictionary["status"] as? String
        seen = dictionary["seen"] as? Bool
        
        imageUrl = dictionary["imageUrl"] as? String
        imageHeight = dictionary["imageHeight"] as? NSNumber
        imageWidth = dictionary["imageWidth"] as? NSNumber
        
        videoUrl = dictionary["videoUrl"] as? String
      
        localImage = dictionary["localImage"] as? UIImage
        localVideoUrl = dictionary["localVideoUrl"] as? String
      
        voiceEncodedString = dictionary["voiceEncodedString"] as? String
        voiceData = dictionary["voiceData"] as? Data //unused
        voiceDuration = dictionary["voiceDuration"] as? String
        voiceStartTime = dictionary["voiceStartTime"] as? Int
      
        estimatedFrameForText = dictionary["estimatedFrameForText"] as? CGRect
        imageCellHeight = dictionary["imageCellHeight"] as? NSNumber
      
        senderName = dictionary["senderName"] as? String
    }
}
