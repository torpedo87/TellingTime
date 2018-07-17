//
//  MainViewController.swift
//  TellingTime
//
//  Created by junwoo on 15/07/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  lazy var clockView = ClockView()
  lazy var speakerButton = SpeakerButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  func setupView() {
    view.backgroundColor = .white
    view.addSubview(clockView)
    view.addSubview(speakerButton)
    
    clockView.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width - 50)
      $0.height.equalTo(clockView.snp.width)
      $0.center.equalToSuperview()
    }
    
    speakerButton.snp.makeConstraints {
      $0.width.height.equalTo(100)
      $0.top.equalTo(clockView.snp.bottom).offset(50)
      $0.centerX.equalToSuperview()
    }
  }
}
