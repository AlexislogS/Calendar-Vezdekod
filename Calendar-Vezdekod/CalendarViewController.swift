//
//  CalendarViewController.swift
//  Calendar-Vezdekod
//
//  Created by Alex Yatsenko on 23.04.2022.
//

import UIKit

class CalendarViewController: UIViewController {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  private let calendarManager = CalendarManager.shared
  private var selectedDate = Date()
  private var totalSquares = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    setMonthView()
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
    
    title = calendarManager.monthString(date: selectedDate)
    collectionView.reloadData()
  }
}

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    totalSquares.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendar", for: indexPath)
    (cell as? CalendarCell)?.dayOfMonth.text = totalSquares[indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: (collectionView.frame.size.width - 2) / 8, height: (collectionView.frame.size.height - 2) / 8)
  }
}
