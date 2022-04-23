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
    return dateFormatter.string(from: date)
  }
  
  func yearString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter.string(from: date)
  }
  
  func daysInMonth(date: Date) -> Int {
    calendar.range(of: .day, in: .month, for: date)?.count ?? 0
  }
  
  func dayOffMonth(date: Date) -> Int {
    calendar.dateComponents([.day], from: date).day ?? 0
  }
  
  func firstOfMonth(date: Date) -> Date? {
    let components = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: components)
  }
  
  func weekDay(date: Date) -> Int {
    (calendar.dateComponents([.weekday], from: date).weekday ?? 0) - 2
  }
}
