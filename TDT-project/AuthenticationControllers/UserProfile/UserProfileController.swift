//
//  UserProfileController.swift
//  TDT-project
//
//  Created by Danila Zykin on 11.03.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit
import Firebase
import ARSLineProgress

class UserProfileController: UIViewController {
  
  let userProfileContainerView = UserProfileContainerView()
  let avatarOpener = AvatarOpener()
  let userProfileDataDatabaseUpdater = UserProfileDataDatabaseUpdater()
  typealias CompletionHandler = (_ success: Bool) -> Void

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.addSubview(userProfileContainerView)
      
        configureNavigationBar()
        configureContainerView()
        configureColorsAccordingToTheme()
    }
  
    fileprivate func configureNavigationBar () {
      let rightBarButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(rightBarButtonDidTap))
      self.navigationItem.rightBarButtonItem = rightBarButton
      self.title = "Profile"
      self.navigationItem.setHidesBackButton(true, animated: true)
    }
  
    fileprivate func configureContainerView() {
      userProfileContainerView.frame = view.bounds
      userProfileContainerView.bioPlaceholderLabel.isHidden = !userProfileContainerView.bio.text.isEmpty
      userProfileContainerView.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openUserProfilePicture)))
      userProfileContainerView.bio.delegate = self
      userProfileContainerView.name.delegate = self
    }
  
    fileprivate func configureColorsAccordingToTheme() {
      userProfileContainerView.profileImageView.layer.borderColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0).cgColor
      userProfileContainerView.userData.layer.borderColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0).cgColor
      userProfileContainerView.name.textColor = UIColor.black
      userProfileContainerView.bio.layer.borderColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0).cgColor
      userProfileContainerView.bio.textColor = UIColor.black
      userProfileContainerView.bio.keyboardAppearance = .default
      userProfileContainerView.name.keyboardAppearance = .default
    }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    userProfileContainerView.frame = view.bounds
    userProfileContainerView.layoutIfNeeded()
  }
  
    @objc fileprivate func openUserProfilePicture() {
      guard currentReachabilityStatus != .notReachable else {
        basicErrorAlertWith(title: basicErrorTitleForAlert, message: noInternetError, controller: self)
        return
      }
      avatarOpener.delegate = self
      avatarOpener.handleAvatarOpening(avatarView: userProfileContainerView.profileImageView, at: self,
                                       isEditButtonEnabled: true, title: .user)
    }
}

extension UserProfileController {
  
  @objc func rightBarButtonDidTap () {
   userProfileContainerView.name.resignFirstResponder()
    if userProfileContainerView.name.text?.count == 0 ||
       userProfileContainerView.name.text!.trimmingCharacters(in: .whitespaces).isEmpty {
       userProfileContainerView.name.shake()
    } else {
       
      if currentReachabilityStatus == .notReachable {
        basicErrorAlertWith(title: "No internet connection", message: noInternetError, controller: self)
        return
      }
      
      updateUserData()
      setOnlineStatus()
    }
  }
  
  func checkIfUserDataExists(completionHandler: @escaping CompletionHandler) {
    
    let nameReference = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("name")
    nameReference.observe(.value, with: { (snapshot) in
      if snapshot.exists() {
        self.userProfileContainerView.name.text = snapshot.value as? String
      }
    })
    
    let bioReference = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("bio")
    bioReference.observe(.value, with: { (snapshot) in
      if snapshot.exists() {
        self.userProfileContainerView.bio.text = snapshot.value as? String
      }
    })
    
    
    let photoReference = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("photoURL")
    photoReference.observe(.value, with: { (snapshot) in
      
      if snapshot.exists() {
        guard let urlString = snapshot.value as? String else { return }
        self.userProfileContainerView.profileImageView.sd_setImage(with: URL(string: urlString), placeholderImage: nil, options: [.scaleDownLargeImages , .continueInBackground], completed: { (_, _, _, _) in
           completionHandler(true)
        })
      } else {
        completionHandler(true)
      }
    })
  }
  
  func updateUserData() {
    ARSLineProgress.ars_showOnView(self.view)

    let userReference = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
    userReference.updateChildValues(["name": userProfileContainerView.name.text!,
                                     "phoneNumber": userProfileContainerView.phone.text!,
                                     "bio": userProfileContainerView.bio.text!]) { (_, _) in
      ARSLineProgress.hide()
      self.dismiss(animated: true) {
        AppUtility.lockOrientation(.allButUpsideDown)
      }
    }
  }
}

extension UserProfileController: UITextViewDelegate {


  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
    if text == "\n" {
      textView.resignFirstResponder()
      return false
    }

    return textView.text.count + (text.count - range.length) <= userProfileContainerView.bioMaxCharactersCount
  }
}

extension UserProfileController: UITextFieldDelegate { }
