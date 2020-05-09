//
//  UserDefaultsManager.swift
//  TDT-project
//
//  Created by Roma Babajanyan on 09/03/2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit
import Firebase

/// Singleton instance of UserDefaultsManager
let userDefaults = UserDefaultsManager()

/// An object that uses UserDefaults to gain access to important data to be stored that is used thourght all app launches
class UserDefaultsManager: NSObject {
  
  fileprivate let defaults = UserDefaults.standard
  
  /// String representing key for authVerificationID
  let authVerificationID = "authVerificationID"
	
  /// String representing key for changeNumberAuthVerificationID
  let changeNumberAuthVerificationID = "ChangeNumberAuthVerificationID"
	
  /// String representing key for changeNumberAuthVerificationID
  let selectedTheme = "SelectedTheme"

  /// String representing key for hasRunBefore
  let hasRunBefore = "hasRunBefore"

  /// String representing key for biometricType
  let biometricType = "biometricType"
	
  /// String representing key for inAppNotifications
  let inAppNotifications = "In-AppNotifications"

  /// String prepresenting key for inAppSounds
  let inAppSounds = "In-AppSounds"
	
  /// String representing key for inAppVibration
  let inAppVibration = "In-AppVibration"
	
  /// String represengin key for biometricalAuth
  let biometricalAuth = "BiometricalAuth"
  
	
	/// Updates data  associated with the specified key
	/// - Parameters:
	///   - key: sprecified key
	///   - data: data for update
  func updateObject(for key: String, with data: Any?) {
    defaults.set(data, forKey: key)
    defaults.synchronize()
  }
  //
  
	
	/// Removes object of given key from UserDefaults
	/// - Parameter key: given key
  func removeObject(for key: String) {
    defaults.removeObject(forKey: key)
  }
  //
  
	
	/// Returns the string associated with the specified key
	/// - Parameter key: specified key
	/// - Returns: returned optional string value
  func currentStringObjectState(for key: String) -> String? {
    return defaults.string(forKey: key)
  }
  
	/// Returns the integer associated with the specified key
	/// - Parameter key: specified key
	/// - Returns: returned optional int value
  func currentIntObjectState(for key: String) -> Int? {
    return defaults.integer(forKey: key)
  }
  
	/// Returns  boolean associated with the specified key
	/// - Parameter key: specified key
	/// - Returns: returned optional string value
  func currentBoolObjectState(for key: String) -> Bool {
    return defaults.bool(forKey: key)
  }
  //
  

	/// Configures apps userDefaults for the initial launch
  func configureInitialLaunch() {
    if defaults.bool(forKey: hasRunBefore) != true {
      do { try Auth.auth().signOut() } catch {}
      updateObject(for: hasRunBefore, with: true)
    }
    setDefaultsForSettings()
  }
  
	/// Performs setup of initial values to the initial required keys
  func setDefaultsForSettings() {
    
    if defaults.object(forKey: inAppNotifications) == nil {
      updateObject(for: inAppNotifications, with: true)
    }
    
    if defaults.object(forKey: inAppSounds) == nil {
      updateObject(for: inAppSounds, with: true)
    }
    
    if defaults.object(forKey: inAppVibration) == nil {
      updateObject(for: inAppVibration, with: true)
    }
    
    if defaults.object(forKey: biometricalAuth) == nil {
      updateObject(for: biometricalAuth, with: false)
    }
  }
}
