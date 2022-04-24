//
//  DaysViewController.swift
//  Calendar-Vezdekod
//
//  Created by Alex Yatsenko on 23.04.2022.
//

import UIKit

class DaysViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var selectedDate = Date()
  var changedDay: ((String?, String?) -> Void)?
  
  private var totalSquares = [String]()
  private var selectedFirstDay: Int?
  private var selectedSecondDay: Int?
  private let calendarManager = CalendarManager.shared
  private let storageManager = StorageManager.shared
  private var storageKey: String { calendarManager.monthNumberString(date: selectedDate) }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.allowsMultipleSelection = true
    setMonthView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let range = storageManager.ranges[storageKey] {
      selectedFirstDay = range.lowerBound
      selectedSecondDay = range.upperBound
      selectRange(range)
    }
    updateSelectedDay()
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
  
  override func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool { false }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard !totalSquares[indexPath.item].isEmpty else {
      selectedFirstDay = nil
      selectedSecondDay = nil
      collectionView.indexPathsForSelectedItems?.forEach({ collectionView.deselectItem(at: $0, animated: true) })
      storageManager.ranges[storageKey] = nil
      updateSelectedDay()
      return
    }
    let currentIndex = indexPath.item
    if selectedFirstDay == nil && selectedSecondDay == nil {
      selectedFirstDay = currentIndex
    } else if let firstIndex = selectedFirstDay, selectedSecondDay == nil {
      let secondIndex = currentIndex
      selectedSecondDay = currentIndex
      let range: ClosedRange<Int>
      if firstIndex < secondIndex {
        range = (firstIndex...secondIndex)
      } else {
        range = (secondIndex...firstIndex)
      }
      selectRange(range)
      storageManager.ranges[storageKey] = range
    } else {
      collectionView.indexPathsForSelectedItems?.forEach({ collectionView.deselectItem(at: $0, animated: true) })
      storageManager.ranges[storageKey] = nil
      selectedSecondDay = nil
      selectedFirstDay = currentIndex
      collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
    }
    updateSelectedDay()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
    let clientWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
    let contentWidth = clientWidth - layout.sectionInset.left - layout.sectionInset.right
    let itemWidth = ((contentWidth - (7 - 1) * layout.minimumInteritemSpacing) / 7).rounded(.down)
    return CGSize(width: itemWidth, height: itemWidth)
  }
  
  private func selectRange(_ range: ClosedRange<Int>) {
    for index in range {
      collectionView.selectItem(at:  IndexPath(item: index, section: 0), animated: true, scrollPosition: .top)
    }
  }
  
  private func updateSelectedDay() {
    changedDay?(selectedFirstDay == nil ? nil : totalSquares[selectedFirstDay!], selectedSecondDay == nil ? nil : totalSquares[selectedSecondDay!])
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
