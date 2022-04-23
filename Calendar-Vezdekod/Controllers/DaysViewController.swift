//
//  DaysViewController.swift
//  Calendar-Vezdekod
//
//  Created by Alex Yatsenko on 23.04.2022.
//

import UIKit

class DaysViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var selectedDate = Date()
  
  private var totalSquares = [String]()
  private let calendarManager = CalendarManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.allowsMultipleSelection = true
    if #available(iOS 14.0, *) {
      collectionView.allowsMultipleSelectionDuringEditing = true
    }
    setMonthView()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    totalSquares.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendar", for: indexPath)
    let text = totalSquares[indexPath.item]
    (cell as? CalendarCell)?.dayOfMonth.text = text
    if !text.isEmpty {
      (cell as? CalendarCell)?.backgroundColor = .systemGray3
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
    let clientWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
    let contentWidth = clientWidth - layout.sectionInset.left - layout.sectionInset.right
    let itemWidth = ((contentWidth - (7 - 1) * layout.minimumInteritemSpacing) / 7).rounded(.down)
    return CGSize(width: itemWidth, height: itemWidth)
  }
  
  private func setMonthView() {
    totalSquares.removeAll()
    
    let daysInMonth = calendarManager.daysInMonth(date: selectedDate)
    guard let firstDayOfMonth = calendarManager.firstOfMonth(date: selectedDate) else { return }
    let startingSpaces = calendarManager.weekDay(date: firstDayOfMonth)
    
    var count = 1
    
    while count <= 42 {
      if count <= startingSpaces || count - startingSpaces > daysInMonth {
        totalSquares .append("")
      } else {
        totalSquares.append(String(count - startingSpaces))
      }
      count += 1
    }
    
    collectionView.reloadData()
  }
}
