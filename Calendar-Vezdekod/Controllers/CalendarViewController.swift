//
//  CalendarViewController.swift
//  Calendar-Vezdekod
//
//  Created by Alex Yatsenko on 23.04.2022.
//

import UIKit

class CalendarViewController: UIViewController {
  
  private let calendarManager = CalendarManager.shared
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let pageVC = segue.destination as? MonthPageViewController {
      title = calendarManager.monthString(date: Date())
      pageVC.selectedDates = createSelectedDates(date: Date())
      pageVC.changedMonth = { [weak self] newDate in
        self?.title = self?.calendarManager.monthString(date: newDate)
      }
    }
  }
  
  private func createSelectedDates(date: Date) -> [Date] {
    guard let prevDate = calendarManager.minusMonth(date: date), let nextDate = calendarManager.plusMonth(date: date) else { return [] }
    
    var prevDates = [prevDate]
    var nextDates = [nextDate]
    
    for _ in 1...5 {
      if let lastDate = prevDates.last, let newDate = calendarManager.minusMonth(date: lastDate) {
        prevDates.append(newDate)
      }
      
      if let lastDate = nextDates.last, let newDate = calendarManager.plusMonth(date: lastDate) {
        nextDates.append(newDate)
      }
    }
    
    prevDates.reverse()
    prevDates.append(date)
    
    return prevDates + nextDates
  }
}
