//
//  Public.swift
//  TDT-project
//
//  Created by Danila Zykin on 10.03.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

import UIKit
import Firebase
import SystemConfiguration
import SDWebImage
import Photos

struct ScreenSize {
  static let width = UIScreen.main.bounds.size.width
  static let height = UIScreen.main.bounds.size.height
  static let maxLength = max(ScreenSize.width, ScreenSize.height)
  static let frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
}

struct DeviceType {
  static let iPhoneX = UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.maxLength == 812.0 || ScreenSize.maxLength == 896.0)
}

extension UIApplication {
  class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let navigationController = controller as? UINavigationController {
      return topViewController(controller: navigationController.visibleViewController)
    }
    if let tabController = controller as? UITabBarController {
      if let selected = tabController.selectedViewController {
        return topViewController(controller: selected)
      }
    }
    if let presented = controller?.presentedViewController {
      return topViewController(controller: presented)
    }
    return controller
  }
}

struct AppUtility {
  
  static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
    
    if let delegate = UIApplication.shared.delegate as? AppDelegate {
      delegate.orientationLock = orientation
    }
  }

  static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
    self.lockOrientation(orientation)
    UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
  }
}

func topViewController(rootViewController: UIViewController?) -> UIViewController? {
  guard let rootViewController = rootViewController else {
    return nil
  }
  
  guard let presented = rootViewController.presentedViewController else {
    return rootViewController
  }
  
  switch presented {
  case let navigationController as UINavigationController:
    return topViewController(rootViewController: navigationController.viewControllers.last)
    
  case let tabBarController as UITabBarController:
    return topViewController(rootViewController: tabBarController.selectedViewController)
    
  default:
    return topViewController(rootViewController: presented)
  }
}

let cameraAccessDeniedMessage = "TDT needs access to your camera to take photos and videos.\n\nPlease go to Settings –– Privacy –– Camera –– and set TDT to ON."
let photoLibraryAccessDeniedMessage = "TDT needs access to your photo library to send photos and videos.\n\nPlease go to Settings –– Privacy –– Photos –– and set TDT to ON."

let cameraAccessDeniedMessageProfilePicture = "TDT needs access to your camera to take photo for your profile.\n\nPlease go to Settings –– Privacy –– Camera –– and set TDT to ON."
let photoLibraryAccessDeniedMessageProfilePicture = "TDT needs access to your photo library to select photo for your profile.\n\nPlease go to Settings –– Privacy –– Photos –– and set TDT to ON."

let basicErrorTitleForAlert = "Error"
let basicTitleForAccessError = "Please Allow Access"
let noInternetError = "Internet is not available. Please try again later"

let deletionErrorMessage = "There was a problem when deleting. Try again later."
let cameraNotExistsMessage = "You don't have camera"
let thumbnailUploadError = "Failed to upload your image to database. Please, check your internet connection and try again."



extension Bool {
  init<T: BinaryInteger>(_ num: T) {
    self.init(num != 0)
  }
}

func basicErrorAlertWith (title: String, message: String, controller: UIViewController) {
  
	let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
	alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
  controller.present(alert, animated: true, completion: nil)
}

func libraryAccessChecking() -> Bool {

  let status = PHPhotoLibrary.authorizationStatus()

  switch status {
  case .authorized:
    return true

  case .denied, .restricted :
    return false

  case .notDetermined:
    return false
	@unknown default:
		fatalError()
	}
}

public let statusOnline = "Online"

func setOnlineStatus()  {
  
  if Auth.auth().currentUser != nil {
    let onlineStatusReference = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("OnlineStatus")
    let connectedRef = Database.database().reference(withPath: ".info/connected")
    
    connectedRef.observe(.value, with: { (snapshot) in
      guard let connected = snapshot.value as? Bool, connected else { return }
      onlineStatusReference.setValue(statusOnline)
     
      onlineStatusReference.onDisconnectSetValue(ServerValue.timestamp())
    })
  }
}

extension UINavigationItem {
  
  func setTitle(title:String, subtitle:String) {
    
    let one = UILabel()
    one.text = title
    one.textColor = UIColor.black
    one.font = UIFont.systemFont(ofSize: 17)
    one.sizeToFit()
    
    let two = UILabel()
    two.text = subtitle
    two.font = UIFont.systemFont(ofSize: 12)
    two.textAlignment = .center
    two.textColor = UIColor(red:0.67, green:0.67, blue:0.67, alpha:1.0)
    two.sizeToFit()
    
    let stackView = UIStackView(arrangedSubviews: [one, two])
    stackView.distribution = .equalCentering
    stackView.axis = .vertical
    
    let width = max(one.frame.size.width, two.frame.size.width)
    stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
    
    one.sizeToFit()
    two.sizeToFit()
    self.titleView = stackView
  }
}

extension PHAsset {
  
  var originalFilename: String? {
    
    var fname:String?
    
    if #available(iOS 9.0, *) {
      let resources = PHAssetResource.assetResources(for: self)
      if let resource = resources.first {
        fname = resource.originalFilename
      }
    }
    
    if fname == nil {
      // this is an undocumented workaround that works as of iOS 9.1
      fname = self.value(forKey: "filename") as? String
    }
    
    return fname
  }
}

func createImageThumbnail (_ image: UIImage) -> UIImage {
  
  let actualHeight:CGFloat = image.size.height
  let actualWidth:CGFloat = image.size.width
  let imgRatio:CGFloat = actualWidth/actualHeight
  let maxWidth:CGFloat = 150.0
  let resizedHeight:CGFloat = maxWidth/imgRatio
  let compressionQuality:CGFloat = 0.5
  
  let rect:CGRect = CGRect(x: 0, y: 0, width: maxWidth, height: resizedHeight)
  UIGraphicsBeginImageContext(rect.size)
  image.draw(in: rect)
  let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
	let imageData: Data = img.jpegData(compressionQuality: compressionQuality)!
  UIGraphicsEndImageContext()
  
  return UIImage(data: imageData)!
}

func compressImage(image: UIImage) -> Data {
  // Reducing file size to a 10th
  
  var actualHeight : CGFloat = image.size.height
  var actualWidth : CGFloat = image.size.width
  let maxHeight : CGFloat = 1920.0
  let maxWidth : CGFloat = 1080.0
  var imgRatio : CGFloat = actualWidth/actualHeight
  let maxRatio : CGFloat = maxWidth/maxHeight
  var compressionQuality : CGFloat = 0.8
  
  if (actualHeight > maxHeight || actualWidth > maxWidth) {
    
    if (imgRatio < maxRatio) {
      
      //adjust width according to maxHeight
      imgRatio = maxHeight / actualHeight;
      actualWidth = imgRatio * actualWidth;
      actualHeight = maxHeight;
    } else if (imgRatio > maxRatio) {
      
      //adjust height according to maxWidth
      imgRatio = maxWidth / actualWidth;
      actualHeight = imgRatio * actualHeight;
      actualWidth = maxWidth;
      
    } else {
      
      actualHeight = maxHeight
      actualWidth = maxWidth
      compressionQuality = 1
    }
  }
  
  let rect = CGRect(x: 0.0, y: 0.0, width:actualWidth, height:actualHeight)
  UIGraphicsBeginImageContext(rect.size)
  image.draw(in: rect)
  let img = UIGraphicsGetImageFromCurrentImageContext()
	let imageData = img!.jpegData(compressionQuality: compressionQuality)
  UIGraphicsEndImageContext();
  
  return imageData!
}

public extension UIView {
  
  func shake(count : Float? = nil,for duration : TimeInterval? = nil,withTranslation translation : Float? = nil) {
    
    // You can change these values, so that you won't have to write a long function
    let defaultRepeatCount = 3
    let defaultTotalDuration = 0.1
    let defaultTranslation = -8
    
    let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
		animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    
    animation.repeatCount = count ?? Float(defaultRepeatCount)
    animation.duration = (duration ?? defaultTotalDuration)/TimeInterval(animation.repeatCount)
    animation.autoreverses = true
    animation.byValue = translation ?? defaultTranslation
    layer.add(animation, forKey: "shake")
  }
}

func uploadAvatarForUserToFirebaseStorageUsingImage(_ image: UIImage, quality: CGFloat, completion: @escaping (_  imageUrl: String) -> ()) {
  let imageName = UUID().uuidString
  let ref = Storage.storage().reference().child("userProfilePictures").child(imageName)

  if let uploadData = image.jpegData(compressionQuality: quality) {
    ref.putData(uploadData, metadata: nil) { (metadata, error) in
      guard error == nil else { completion(""); return }
      
      ref.downloadURL(completion: { (url, error) in
        guard error == nil, let imageURL = url else { completion(""); return }
         completion(imageURL.absoluteString)
      })
    }
  }
}

private var backgroundView: UIView = {
  let backgroundView = UIView()
  backgroundView.backgroundColor = UIColor.black
  backgroundView.alpha = 0.8
  backgroundView.layer.cornerRadius = 0
  backgroundView.layer.masksToBounds = true
  
  return backgroundView
}()

private var activityIndicator: UIActivityIndicatorView = {
	var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
  activityIndicator.hidesWhenStopped = true
  activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
	activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
  activityIndicator.autoresizingMask = [.flexibleLeftMargin , .flexibleRightMargin , .flexibleTopMargin , .flexibleBottomMargin]
  activityIndicator.isUserInteractionEnabled = false
  
  return activityIndicator
}()


extension UIImageView {
  
  func showActivityIndicator() {
    
    self.addSubview(backgroundView)
    self.addSubview(activityIndicator)
		activityIndicator.style = .white
    activityIndicator.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    DispatchQueue.main.async {
      activityIndicator.startAnimating()
    }
  }
  
  func hideActivityIndicator() {
    DispatchQueue.main.async {
      activityIndicator.stopAnimating()
    }
    
    activityIndicator.removeFromSuperview()
    backgroundView.removeFromSuperview()
  }
}

extension UITableViewCell {
  var selectionColor: UIColor {
    set {
      let view = UIView()
      view.backgroundColor = newValue

      self.selectedBackgroundView = view
    }
    get {
      return self.selectedBackgroundView?.backgroundColor ?? UIColor.clear
    }
  }
}

protocol Utilities {}

extension NSObject: Utilities {
  
  enum ReachabilityStatus {
    case notReachable
    case reachableViaWWAN
    case reachableViaWiFi
  }
  
  var currentReachabilityStatus: ReachabilityStatus {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
        SCNetworkReachabilityCreateWithAddress(nil, $0)
      }
    }) else {
      return .notReachable
    }
    
    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
      return .notReachable
    }
    
    if flags.contains(.reachable) == false {
      // The target host is not reachable.
      return .notReachable
    }
    else if flags.contains(.isWWAN) == true {
      // WWAN connections are OK if the calling application is using the CFNetwork APIs.
      return .reachableViaWWAN
    }
    else if flags.contains(.connectionRequired) == false {
      // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
      return .reachableViaWiFi
    }
    else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
      // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
      return .reachableViaWiFi
    }
    else {
      return .notReachable
    }
  }
}
