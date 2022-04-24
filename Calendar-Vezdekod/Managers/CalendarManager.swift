//
//  CalendarManager.swift
//  Calendar-Vezdekod
//
//  Created by Alex Yatsenko on 23.04.2022.
//

import Foundation

class CalendarManager {
  
  private let calendar = Calendar.current
  
  static let shared = CalendarManager()
  
  private init() {}
  
  func plusMonth(date: Date) -> Date? {
    calendar.date(byAdding: .month, value: 1, to: date)
  }
  
  func minusMonth(date: Date) -> Date? {
    calendar.date(byAdding: .month, value: -1, to: date)
  }
  
  func monthString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "LLLL"
    return dateFormatter.string(from: date).capitalized
  }
  
  func monthNumberString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM.yy"
    return dateFormatter.string(from: date)
  }
  
  func daysInMonth(date: Date) -> Int {
    calendar.range(of: .day, in: .month, for: date)?.count ?? 0
  }
  
  func firstOfMonth(date: Date) -> Date? {
    let components = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: components)
  }
  
  func weekDay(date: Date) -> Int {
    let weekday = (calendar.dateComponents([.weekday], from: date).weekday ?? 0) - 2
    if weekday < 0 {
      return 7 + weekday
    }
    return weekday
  }
}
