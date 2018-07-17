//
//  SpeakerButton.swift
//  TellingTime
//
//  Created by junwoo on 17/07/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class SpeakerButton: UIButton {
  
  override func draw(_ rect: CGRect) {
    let circle = UIBezierPath(ovalIn: rect.insetBy(dx: 5, dy: 5))
    UIColor.gray.setFill()
    circle.fill()
    
    UIColor.white.setStroke()
    let curve = UIBezierPath()
    let points = getPoints(rect: rect)
    curve.move(to: points[0].0)
    curve.addCurve(to: points[0].1, controlPoint1: points[0].2, controlPoint2: points[0].2)
    
    curve.move(to: points[1].0)
    curve.addCurve(to: points[1].1, controlPoint1: points[1].2, controlPoint2: points[1].2)
    
    curve.move(to: points[2].0)
    curve.addCurve(to: points[2].1, controlPoint1: points[2].2, controlPoint2: points[2].2)
    curve.lineWidth = 4.0
    curve.lineCapStyle = .round
    curve.stroke()
  }
  
  private func getPoints(rect: CGRect) -> [(CGPoint, CGPoint, CGPoint)] {
    let x1 = rect.width / 4
    let x2 = rect.width / 2
    let x3 = rect.width * 3 / 4
    
    let topY1 = getY(x: x1, rect: rect, a: 1 / 3)
    let bottomY1 = getY(x: x1, rect: rect, a: -1 / 3)
    let topY2 = getY(x: x2, rect: rect, a: 1 / 3)
    let bottomY2 = getY(x: x2, rect: rect, a: -1 / 3)
    let topY3 = getY(x: x3, rect: rect, a: 1 / 3)
    let bottomY3 = getY(x: x3, rect: rect, a: -1 / 3)
    
    let start1 = CGPoint(x: x1, y: topY1)
    let end1 = CGPoint(x: x1, y: bottomY1)
    let start2 = CGPoint(x: x2, y: topY2)
    let end2 = CGPoint(x: x2, y: bottomY2)
    let start3 = CGPoint(x: x3, y: topY3)
    let end3 = CGPoint(x: x3, y: bottomY3)
    
    let control1 = CGPoint(x: x1 * 1.2, y: rect.midY)
    let control2 = CGPoint(x: x2 * 1.2, y: rect.midY)
    let control3 = CGPoint(x: x3 * 1.2, y: rect.midY)
    let tuple1 = (start1, end1, control1)
    let tuple2 = (start2, end2, control2)
    let tuple3 = (start3, end3, control3)
    return [tuple1, tuple2, tuple3]
  }
  
  private func getY(x: CGFloat, rect: CGRect, a: CGFloat) -> CGFloat {
    return rect.midY - a * x
  }
}
