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
  var numberLayer = CAShapeLayer()
  var time = -CGFloat.pi / 2
  var startAngle: CGFloat = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    layer.addSublayer(dial)
    layer.addSublayer(numberLayer)
    layer.addSublayer(pointer)
    
    dial.strokeColor = UIColor.black.cgColor
    dial.fillColor = UIColor.white.cgColor
    dial.shadowColor = UIColor.gray.cgColor
    dial.shadowOpacity = 0.7
    dial.shadowRadius = 8
    dial.shadowOffset = CGSize.zero
    
    let pan = UIPanGestureRecognizer(target: self,
                                     action: #selector (handlePan(recognizer:)))
    addGestureRecognizer(pan)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let dialPath = UIBezierPath(ovalIn: bounds)
    dial.path = dialPath.cgPath
    
    drawNumbers()
    
    let arrow = buildArrow(width: 10, length: bounds.midX - 20, depth: 20)
    pointer.path = arrow.cgPath
    pointer.strokeColor = UIColor.darkGray.cgColor
    pointer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    pointer.lineWidth = 4
    pointer.lineCap = CAShapeLayerLineCap.round
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
  
  private func drawNumbers() {
    numberLayer.bounds = bounds
    let center = CGPoint(x: bounds.midX, y: bounds.midY)
    numberLayer.position = center
    
    let renderer = UIGraphicsImageRenderer(size: bounds.size)
    let image = renderer.image { canvas in
      //draw numbers
      let context = canvas.cgContext
      
      for number in 1...12 {
        context.translateBy(x: center.x, y: center.y)
        context.rotate(by: CGFloat.pi * 2 / 12)
        context.translateBy(x: -center.x, y: -center.y)
        draw(number: number)
      }
      
    }
    
    numberLayer.contents = image.cgImage
  }
  
  func draw(number: Int) {
    let string = "\(number)" as NSString
    let attributes = [NSAttributedString.Key.font: UIFont(name: "Avenir-Heavy", size: 18)!]
    let size = string.size(withAttributes: attributes)
    string.draw(at: CGPoint(x: bounds.width/2 - size.width/2, y: 10), withAttributes: attributes)
  }
  
  @objc func handlePan(recognizer: UIPanGestureRecognizer) {
    if let view = recognizer.view {
      let angle = getAngle(location: recognizer.location(in: view))
      rotate(to: angle)
    }
  }
  
  private func getAngle(location: CGPoint) -> CGFloat {
    let deltaX = location.x - bounds.midX
    let deltaY = location.y - bounds.midY
    let angle = 180 - atan2(deltaX, deltaY) * 180 / .pi
    return angle * .pi / 180
  }
  
  func rotate(to: CGFloat) {
    let animation = CABasicAnimation(keyPath: "transform.rotation.z")
    animation.duration = 0
    animation.fromValue = startAngle
    animation.toValue = to
    animation.repeatCount = 0
    startAngle = to
    pointer.transform = CATransform3DMakeRotation(to, 0, 0, 1)
    pointer.add(animation, forKey: "time")
  }
}
