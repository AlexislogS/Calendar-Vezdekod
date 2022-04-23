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
    setMonthView()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    totalSquares.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendar", for: indexPath)
    (cell as? CalendarCell)?.dayOfMonth.text = totalSquares[indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: (collectionView.frame.size.width - 2) / 8, height: (collectionView.frame.size.height - 2) / 8)
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
