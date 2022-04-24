//
//  StorageManager.swift
//  Calendar-Vezdekod
//
//  Created by Alex Yatsenko on 24.04.2022.
//

import Foundation

class StorageManager {
  
  static let shared = StorageManager()
  
  private let storage = UserDefaults.standard
  
  private init() {}
  
  private enum StorageKeys: String {
    case ranges
  }
  
  var ranges: [String:ClosedRange<Int>] {
    get {
      if let data = storage.value(forKey: StorageKeys.ranges.rawValue) as? Data {
        return (try? JSONDecoder().decode([String:ClosedRange<Int>].self, from: data)) ?? [:]
      }
      return [:]
    }
    set {
      guard let data = try? JSONEncoder().encode(newValue) else { return }
      storage.setValue(data, forKey: StorageKeys.ranges.rawValue)
      storage.synchronize()
    }
  }
}
