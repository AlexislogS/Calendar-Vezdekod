//
//  MonthPageViewController.swift
//  Calendar-Vezdekod
//
//  Created by Alex Yatsenko on 23.04.2022.
//

import UIKit

class MonthPageViewController: UIPageViewController, UIPageViewControllerDataSource {
  
  var selectedDates = [Date]()
  var changedMonth: ((Date) -> Void)?
  
  private var daysVCs = [UIViewController]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let currentIndex = daysVCs.firstIndex(of: viewController) else { return nil }
    changedMonth?(selectedDates[currentIndex])
    guard currentIndex > 0 else { return nil }
    return daysVCs[currentIndex - 1]
  }

  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let currentIndex = daysVCs.firstIndex(of: viewController) else { return nil }
    changedMonth?(selectedDates[currentIndex])
    guard currentIndex < daysVCs.count - 1 else { return nil }
    return daysVCs[currentIndex + 1]
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return daysVCs.count
  }
  
  private func setUp() {
    guard !selectedDates.isEmpty else { return }
    for index in selectedDates.indices {
      let storyboard = UIStoryboard(name: "Main", bundle: .main)
      if let daysVC = storyboard.instantiateViewController(withIdentifier: String(describing: DaysViewController.self)) as? DaysViewController {
        daysVC.selectedDate = selectedDates[index]
        daysVCs.append(daysVC)
      }
    }
    dataSource = self
    setViewControllers([daysVCs[6]], direction: .forward, animated: false)
  }
}
