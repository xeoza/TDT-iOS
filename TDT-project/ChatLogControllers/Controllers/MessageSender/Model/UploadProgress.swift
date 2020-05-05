//
//  UploadProgress.swift
//  TDT-project
//
//  Created by Roman Babajanyan on 05.05.2020.
//  Copyright © 2020 Roman Babajanyan. All rights reserved.
//

import Foundation

class UploadProgress: NSObject {
	var objectID: String
	var progress: Double

	init(objectID: String, progress: Double) {
		self.objectID = objectID
		self.progress = progress
	}
}

extension Array where Element: UploadProgress {

	mutating func setProgress(_ progress: Double, id: String) {
		var array = self as [UploadProgress]

		guard let index = array.firstIndex(where: { (element) -> Bool in
			element.objectID == id
		}) else {
			let element = UploadProgress(objectID: id, progress: progress)
			array.insert(element, at: 0)
			self = array as! [Element]
			return
		}
		array[index].progress = progress
		self = array as! [Element]
	}
}
