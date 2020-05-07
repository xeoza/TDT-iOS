//
//  UserProfileControllerTests.swift
//  TDTTests
//
//  Created by Roma Babajanyan on 06.05.2020.
//  Copyright © 2020 Danila Zykin. All rights reserved.
//

@testable import TDT
import Firebase
import XCTest

class TDTTests_MessageSender: XCTestCase {

	typealias Sender = MessageSender
	
	var databaseRef: DatabaseReference!

	var sender: Sender!

	let converstionDict1 = ["chatID": "test" as AnyObject,
				"chatName": "test" as AnyObject,
				"isGroupChat": false  as AnyObject,
				"chatOriginalPhotoURL": "" as AnyObject,
				"chatThumbnailPhotoURL": "" as AnyObject,
				"chatParticipantsIDs": ["p1", "p2"] as AnyObject]

	let converstionDict2 = ["chatID": "test" as AnyObject,
				"chatName": "test" as AnyObject,
				"isGroupChat": true  as AnyObject,
				"chatOriginalPhotoURL": "" as AnyObject,
				"chatThumbnailPhotoURL": "" as AnyObject,
				"chatParticipantsIDs": ["p1", "p2"] as AnyObject]

	override func setUp() {

		sender = Sender(Conversation(dictionary: converstionDict1), text: "Test Sample", media: [MediaObject]())
		databaseRef = Database.database().reference()
		
		shadowSignIn()
	}
	
	override func tearDown() {
		do{
			try Auth.auth().signOut()
		} catch
		{
			XCTFail("sing out failed")
		}
	}

	func test_sendMessage_default() {
		
		let expect = FIRExpectation
		
		sender.sendMessage { (referenceUrl) in

			self.databaseRef.child("messages").child(self.autochildId(referenceUrl)).observe(.value) { (snap) in
				XCTAssertNotNil(snap.value)
				
				
				let dict = snap.value as? NSDictionary
				XCTAssertNotNil(dict)
				
				XCTAssertEqual(dict?["messageUID"] as! String, self.autochildId(referenceUrl))
				XCTAssertEqual(dict?["fromId"] as! String, Auth.auth().currentUser!.uid)
				XCTAssertEqual(dict?["toId"] as! String, "test")

				expect.fulfill()
			}
		}
		
		waitForExpectations(timeout: 3)
	}
}

// MARK: - Helpers

extension TDTTests_MessageSender {

	var FIRExpectation: XCTestExpectation {
		expectation(description: "For Firebase API")
	}
	
	func shadowSignIn() {
		
		let authPoint = Auth.auth()
		let exp = FIRExpectation
		
		authPoint.signInAnonymously { (_, error) in
			XCTAssertNil(error)
			
			exp.fulfill()
		}
		
		waitForExpectations(timeout: 3)
	}
	
	func autochildId(_ url: String) -> String {
		url.components(separatedBy: "/").last!
	}
}
