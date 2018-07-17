//
//  ClockView.swift
//  TellingTime
//
//  Created by junwoo on 15/07/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class ClockView: UIView {
  
  var dial = CAShapeLayer()
  var pointer = CAShapeLayer()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    layer.addSublayer(dial)
    layer.addSublayer(pointer)
    dial.strokeColor = UIColor.black.cgColor
    dial.fillColor = UIColor.white.cgColor
    dial.shadowColor = UIColor.gray.cgColor
    dial.shadowOpacity = 0.7
    dial.shadowRadius = 8
    dial.shadowOffset = CGSize.zero
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let dialPath = UIBezierPath(ovalIn: bounds)
    dial.path = dialPath.cgPath
    
    let arrow = buildArrow(width: 10, length: bounds.midX - 20, depth: 20)
    pointer.path = arrow.cgPath
    pointer.strokeColor = UIColor.darkGray.cgColor
    pointer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    pointer.lineWidth = 4
    pointer.lineCap = CAShapeLayerLineCap.round
    
    //keyPath에 의해 어떤 애니메이션이 결정됨
    let animation = CABasicAnimation(keyPath: "transform.rotation.z")
    animation.duration = 60
    animation.fromValue = 0
    animation.toValue = Float.pi * 2
    animation.repeatCount = .greatestFiniteMagnitude
    pointer.add(animation, forKey: "time")
  }
  
  private func buildArrow(width: CGFloat, length: CGFloat, depth: CGFloat) -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint.zero)
    let endPoint = CGPoint(x: 0, y: -length)
    path.addLine(to: endPoint)
    
    //화살표 꼭지
    path.move(to: CGPoint(x: 0 - width, y: endPoint.y + depth))
    path.addLine(to: endPoint)
    path.move(to: CGPoint(x: 0 + width, y: endPoint.y + depth))
    path.addLine(to: endPoint)
    
    return path
  }
}
