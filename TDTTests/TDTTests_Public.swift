//
//  TDTTests_Public.swift
//  TDTTests
//
//  Created by Roman Babajanyan on 07.05.2020.
//  Copyright © 2020 Roman Babajanyan. All rights reserved.
//

import XCTest
@testable import TDT
import UIKit
import Photos

class TDTTests_Public: XCTestCase {

	// MARK: - topViewController
	
	typealias App = UIApplication
	
	func test_topVC_default() {
		
		let vc = UIViewController()
		App.shared.keyWindow?.rootViewController = vc
		
		let topVc = App.topViewController()
		
		XCTAssertNotNil(topVc)
		XCTAssertEqual(topVc, vc)
	}
	
	func test_topVC_vc() {
		
		let vc = UIViewController()
		
		let topVC = App.topViewController(controller: vc)
		
		XCTAssertNotNil(topVC)
		XCTAssertEqual(topVC, vc)
	}
	
	func test_topVC_navVC() {

		let vc1 = UIViewController()
		let navVC = UINavigationController.init(rootViewController: vc1)
		
		let topVC = App.topViewController(controller: navVC)
		
		XCTAssertNotNil(topVC)
		XCTAssertEqual(topVC, navVC.visibleViewController)
	}
	
	func test_topVC_tabbarVC() {
		
		let tabbarVC = UITabBarController()
		let vc = UIViewController()
		
		tabbarVC.viewControllers = [vc]
		tabbarVC.selectedViewController = vc
		
		let topVC = App.topViewController(controller: tabbarVC)
		
		XCTAssertNotNil(topVC)
		XCTAssertEqual(topVC, tabbarVC.selectedViewController)
	}
	
	func test_topVC_failure() {
		
		let topVC = App.topViewController(controller: nil)
		
		XCTAssertNil(topVC)
	}
	
	// MARK: - createImageThimbnail
	
	func test_createImageThumbnail_default() {
		
		let img = UIImage(named: "4", in: Bundle(for: type(of: self)), compatibleWith: nil)!
		let thumbNail = createImageThumbnail(img)
		XCTAssertEqual(thumbNail.pngData(), thumb(img).pngData())
	}
	
	func test_createImageThumbnail_failure() {
		
		let img1 = UIImage(named: "3", in: Bundle(for: type(of: self)), compatibleWith: nil)!
		let img2 = UIImage(named: "4", in: Bundle(for: type(of: self)), compatibleWith: nil)!
		
		let tnumbnail = createImageThumbnail(img2)
		
		XCTAssertNotEqual(tnumbnail.pngData(), img1.pngData())
	}
	
	// MARK: - timestampOfChatLogMessage
	
	func test_timestampOfChatLogMessage_default() {
		
		let date1 = Date(timeIntervalSinceNow: -120000)
		let date2 = Date()

		let dateExp1 = "\(date1.getShortDateStringFromUTC())\n\(date1.getTimeStringFromUTC())"
		let chatLogMsgTimestamp1 = timestampOfChatLogMessage(date1)
		XCTAssertEqual(chatLogMsgTimestamp1, dateExp1)
		
		let dateExp2 = date2.getTimeStringFromUTC()
		let chatLogMsgTimestamp2 = timestampOfChatLogMessage(date2)
		XCTAssertEqual(chatLogMsgTimestamp2, dateExp2)
	}

	// MARK: - timeAgoSinceDate
	
	func test_timeAgoSinceDate_years() {

		let date1 = Date(timeIntervalSinceNow: -63072000)
		let date2 = Date(timeIntervalSinceNow: -126144000)

		let exp1 = "last year"
		let act1 = timeAgoSinceDate(date1)
		XCTAssertEqual(act1, exp1)
		
		let exp2 = "1 year ago"
		let act2 = timeAgoSinceDate(date1, numericDates: true)
		XCTAssertEqual(act2, exp2)
		
		let exp3 = "3 years ago"
		let act3 = timeAgoSinceDate(date2)
		XCTAssertEqual(act3, exp3)
	}
	
	func test_timeAgoSinceDate_months() {

		let date1 = Date(timeIntervalSinceNow: -2592000)
		let date2 = Date(timeIntervalSinceNow: -7776000)
		
		let exp1 = "last month"
		let act1 = timeAgoSinceDate(date1)
		XCTAssertEqual(act1, exp1)
		
		let exp2 = "1 month ago"
		let act2 = timeAgoSinceDate(date1, numericDates: true)
		XCTAssertEqual(act2, exp2)
		
		let exp3 = "3 months ago"
		let act3 = timeAgoSinceDate(date2)
		XCTAssertEqual(act3, exp3)
	}
	
	func test_tmieAgoSinceDate_months() {

		let date1 = Date(timeIntervalSinceNow: -604800)
		let date2 = Date(timeIntervalSinceNow: -1814400)
		
		let exp1 = "last week"
		let act1 = timeAgoSinceDate(date1)
		XCTAssertEqual(act1, exp1)
		
		let exp2 = "1 week ago"
		let act2 = timeAgoSinceDate(date1, numericDates: true)
		XCTAssertEqual(act2, exp2)
		
		let exp3 = "3 weeks ago"
		let act3 = timeAgoSinceDate(date2)
		XCTAssertEqual(act3, exp3)
	}
	
	func test_tmieAgoSinceDate_days() {

		let date1 = Date(timeIntervalSinceNow: -86400)
		let date2 = Date(timeIntervalSinceNow: -259200)
		
		let exp1 = "yesterday at \(date1.getTimeStringFromUTC())"
		let act1 = timeAgoSinceDate(date1)
		XCTAssertEqual(act1, exp1)
		
		let exp2 = "1 day ago"
		let act2 = timeAgoSinceDate(date1, numericDates: true)
		XCTAssertEqual(act2, exp2)
		
		let exp3 = "3 days ago"
		let act3 = timeAgoSinceDate(date2)
		XCTAssertEqual(act3, exp3)
	}
	
	func test_tmieAgoSinceDate_hours() {

		let date1 = Date(timeIntervalSinceNow: -3600)
		let date2 = Date(timeIntervalSinceNow: -10800)
		
		let exp1 = "an hour ago"
		let act1 = timeAgoSinceDate(date1)
		XCTAssertEqual(act1, exp1)
		
		let exp2 = "1 hour ago"
		let act2 = timeAgoSinceDate(date1, numericDates: true)
		XCTAssertEqual(act2, exp2)
		
		let exp3 = "3 hours ago"
		let act3 = timeAgoSinceDate(date2)
		XCTAssertEqual(act3, exp3)
	}
	
	func test_tmieAgoSinceDate_minutes() {

		let date1 = Date(timeIntervalSinceNow: -60)
		let date2 = Date(timeIntervalSinceNow: -180)
		
		let exp1 = "a minute ago"
		let act1 = timeAgoSinceDate(date1)
		XCTAssertEqual(act1, exp1)
		
		let exp2 = "1 minute ago"
		let act2 = timeAgoSinceDate(date1, numericDates: true)
		XCTAssertEqual(act2, exp2)
		
		let exp3 = "3 minutes ago"
		let act3 = timeAgoSinceDate(date2)
		XCTAssertEqual(act3, exp3)
	}
	
	func test_tmieAgoSinceDate_seconds() {

		let date1 = Date()

		let exp1 = "just now"
		let act1 = timeAgoSinceDate(date1)
		XCTAssertEqual(act1, exp1)
	}
	
	// MARK: - PHAsset extensions test cases
	
	func test_dataFromAsset() {
		
		let assets = fetchAssets()
		
		assets.enumerateObjects { (asset, _, _) in
			XCTAssertNotNil(dataFromAsset(asset: asset))
		}
	}
	
	func test_uiImageFromAsset() {

		let assets = fetchAssets()

		assets.enumerateObjects { (asset, _, _) in
			XCTAssertNotNil(asset)
			XCTAssertNotNil(uiImageFromAsset(phAsset: asset))
		}
	}
	
	// MARK: - String extensions test cases
	
	func test_doubleValue_default() {
		
		let exp = 2.0
		let act = "2.0".doubleValue
		XCTAssertEqual(act, exp)
	}
	
	func test_doubleValue_failure() {
		
		let exp = Double(0)
		let act = "-".doubleValue
		XCTAssertEqual(act, exp)
	}
	
	func test_digits_default() {

		let exp1 = ""
		let act1 = "".digits
		XCTAssertEqual(act1, exp1)
		
		let exp2 = "123456".digits
		let act2 = "123 hello 456".digits
		XCTAssertEqual(act2, exp2)
		
		let exp3 = "123456".digits
		let act3 = "123456".digits
		XCTAssertEqual(act3, exp3)
	}
	
	// MARK: - Array extensions test cases
	
	// stablePartition
	
	func test_stablePartition_defaultPartition() {
		
		let exp = ([2,4,6,8],[1,3,5,7])
		
		let (act1, act2) = [1,2,3,4,5,6,7,8].stablePartition { (element) -> Bool in
			element % 2 == 0 ? true : false
		}
		
		XCTAssertEqual(exp.0, (act1, act2).0)
		XCTAssertEqual(exp.1, (act1, act2).1)
	}
	
	func test_stablePartition_singlePartition() {
		
		let exp = ([Int](),[1,2,3,4])
		
		let (act1, act2) = [1,2,3,4].stablePartition { (element) -> Bool in
			return false
		}
		
		XCTAssertEqual(exp.0, (act1, act2).0)
		XCTAssertEqual(exp.1, (act1, act2).1)
	}
	
	func test_stablePartition_conversations() {
		
		let testConversations = [DummyConversation(isPinned: true, id: 1),
								 DummyConversation(isPinned: false, id: 2),
								 DummyConversation(isPinned: false, id: 3),
								 DummyConversation(isPinned: true, id: 4)]
		
		let expected = ([testConversations.first!, testConversations.last!], [testConversations[1],testConversations[2]])
		
		let (pinned, notPinned) = testConversations.stablePartition { (conversation) -> Bool in
			conversation.isPinned
		}
		
		XCTAssertEqual(expected.0, (pinned, notPinned).0)
		XCTAssertEqual(expected.1, (pinned, notPinned).1)
	}
}

extension TDTTests_Public {
	
	struct DummyConversation: Equatable {
		
		var isPinned: Bool
		var id: Int
		
		static func ==(lhs: DummyConversation, rhs: DummyConversation) -> Bool {
			return lhs.id == rhs.id && lhs.isPinned == rhs.isPinned
		}
	}
	
	func fetchAssets() -> PHFetchResult<PHAsset> {
		
		let options = PHFetchOptions()
		options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
		options.fetchLimit = 100
		
		return PHAsset.fetchAssets(with: options)
	}
	
	func thumb(_ image: UIImage) -> UIImage {
		
		let rect = CGRect(x: 0, y: 0, width: 150.0, height: 150/(image.size.width/image.size.height))
		UIGraphicsBeginImageContext(rect.size)
		image.draw(in: rect)
		let imgData = UIGraphicsGetImageFromCurrentImageContext()!.jpegData(compressionQuality: 0.5)!
		UIGraphicsEndImageContext()
		
		return UIImage(data: imgData)!
	}
}
