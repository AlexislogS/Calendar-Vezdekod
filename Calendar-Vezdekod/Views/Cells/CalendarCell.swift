//
//  CalendarCell.swift
//  Calendar-Vezdekod
//
//  Created by Alex Yatsenko on 23.04.2022.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
  @IBOutlet weak var dayOfMonth: UILabel!
  
  override var isHighlighted: Bool { didSet { setSelected() } }
  override var isSelected: Bool {
    didSet {
      if dayOfMonth.text?.isEmpty == false {
        contentView.backgroundColor = isSelected ? .systemBlue : .systemGray3
      }
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = bounds.width / 2
  }
  
  private func setSelected() {
    let animator = UIViewPropertyAnimator(duration: 0.7, dampingRatio: 0.4) {
      self.transform = self.isHighlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
    }
    animator.startAnimation()
  }
}
