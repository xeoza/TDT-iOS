//
//  Conversation.swift
//  TDT-project
//
//  Created by Danila Zykin on 30.04.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit

/// An object that represents a conversation instance
class Conversation: NSObject {

  /// Id of the chat
  var chatID: String?
	
  /// Name of the Chat
  var chatName: String?
	
  /// Url of chat photo
  var chatPhotoURL: String?

  /// Url of chat photo
  var chatThumbnailPhotoURL: String?
	
  /// Id of the last message
  var lastMessageID: String?
  /// instance of the last message
  var lastMessage: Message?
	
  /// flast that shows wheather current conversation is group chat
  var isGroupChat: Bool?
	
  /// list that contains id's of participants if conversation is ment to be a group chat
  var chatParticipantsIDs:[String]?

  // admin id
  var admin: String?

  // value of converstation badge for tabBarController
  var badge: Int?
	
  /// flag that determines wheather chat is pinned
  var pinned: Bool?

  /// flag that determines wheather chat is muted
  var muted: Bool?
  
	
	/// Retrieves placeholder of the last chat's message
	/// - Returns: placeholder of the last chat's message
  func messageText() -> String {
    
    let isImageMessage = (lastMessage?.imageUrl != nil || lastMessage?.localImage != nil) && lastMessage?.videoUrl == nil
    let isVideoMessage = (lastMessage?.imageUrl != nil || lastMessage?.localImage != nil) && lastMessage?.videoUrl != nil
    let isVoiceMessage = lastMessage?.voiceEncodedString != nil
    let isTextMessage = lastMessage?.text != nil
    
    guard !isImageMessage else { return  MessageSubtitle.image }
    guard !isVideoMessage else { return MessageSubtitle.video }
    guard !isVoiceMessage else { return MessageSubtitle.audio }
    guard !isTextMessage else { return lastMessage?.text ?? "" }
    
    return MessageSubtitle.empty
  }
	
	/// Default init
	/// - Parameter dictionary: pass a dictionary to initialize required variables of the instance that about to be created
  init(dictionary: [String: AnyObject]?) {
    super.init()
    
    chatID = dictionary?["chatID"] as? String
    chatName = dictionary?["chatName"] as? String
    chatPhotoURL = dictionary?["chatOriginalPhotoURL"] as? String
    chatThumbnailPhotoURL = dictionary?["chatThumbnailPhotoURL"] as? String
    lastMessageID = dictionary?["lastMessageID"] as? String
    lastMessage = dictionary?["lastMessage"] as? Message
    isGroupChat = dictionary?["isGroupChat"] as? Bool
    chatParticipantsIDs = dictionary?["chatParticipantsIDs"] as? [String]
    admin = dictionary?["admin"] as? String
    badge = dictionary?["badge"] as? Int
    pinned = dictionary?["pinned"] as? Bool
    muted = dictionary?["muted"] as? Bool
  }
}
