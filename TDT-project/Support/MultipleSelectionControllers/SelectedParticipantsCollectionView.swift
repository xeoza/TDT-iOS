//
//  SelectedParticipantsCollectionView.swift
//  TDT-project
//
//  Created by Roman Babajanyan on 03.05.2020.
//  Copyright © 2020 Roman Babajanyan. All rights reserved.
//

import UIKit
import SDWebImage

extension SelectParticipantsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return selectedFalconUsers.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = selectedParticipantsCollectionView.dequeueReusableCell(withReuseIdentifier: selectedParticipantsCollectionViewCellID, for: indexPath) as? SelectedParticipantsCollectionViewCell ?? SelectedParticipantsCollectionViewCell()
    
    cell.title.text = selectedFalconUsers[indexPath.item].name

    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return selectSize(indexPath: indexPath)
  }
  
  func selectSize(indexPath: IndexPath) -> CGSize  {
    let cellHeight: CGFloat = 35
    guard let userName = selectedFalconUsers[indexPath.row].name else { return  CGSize(width: 100, height: cellHeight) }
    return CGSize(width: estimateFrameForText(userName).width, height: cellHeight)
  }
  
  func estimateFrameForText(_ text: String) -> CGRect {
    let size = CGSize(width: 200, height: 10000)
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
		return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)], context: nil).integral
  }
}
