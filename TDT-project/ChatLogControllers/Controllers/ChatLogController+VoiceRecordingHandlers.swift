//
//  ChatLogController+VoiceRecordingHandlers.swift
//  TDT-project
//
//  Created by Roman Babajanyan on 05.05.2020.
//  Copyright © 2020 Roman Babajanyan. All rights reserved.
//

import UIKit
import AVFoundation

extension ChatLogController {
  
  @objc func toggleVoiceRecording () {
    
    if voiceRecordingViewController == nil {
      voiceRecordingViewController = VoiceRecordingViewController()
    }

    inputContainerView.recordVoiceButton.isSelected = !inputContainerView.recordVoiceButton.isSelected
    
    if inputContainerView.recordVoiceButton.isSelected {
      voiceRecordingViewController.inputContainerView = inputContainerView
      inputContainerView.attachButton.isSelected = false
      inputContainerView.inputTextView.inputView = voiceRecordingViewController.view
      inputContainerView.inputTextView.reloadInputViews()
      inputContainerView.inputTextView.becomeFirstResponder()
      inputContainerView.inputTextView.addGestureRecognizer(inputTextViewTapGestureRecognizer)
    } else {
      inputContainerView.inputTextView.inputView = nil
      inputContainerView.inputTextView.reloadInputViews()
      inputContainerView.inputTextView.removeGestureRecognizer(inputTextViewTapGestureRecognizer)
    }
  }
  
  func getAudioDurationInHours(from data: Data) -> String? {
    do {
      chatLogAudioPlayer = try AVAudioPlayer(data: data)
      let duration = Int(chatLogAudioPlayer.duration)
      let hours = Int(duration) / 3600
      let minutes = Int(duration) / 60 % 60
      let seconds = Int(duration) % 60
      return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    } catch {
      print("error playing")
      return String(format:"%02i:%02i:%02i", 0, 0, 0)
    }
  }
  
  func getAudioDurationInSeconds(from data: Data) -> Int? {
    do {
      chatLogAudioPlayer = try AVAudioPlayer(data: data)
      let duration = Int(chatLogAudioPlayer.duration)
      return duration
    } catch {
      print("error playing")
      return nil
    }
  }
}
