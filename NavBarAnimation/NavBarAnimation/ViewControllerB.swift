//
//  ViewControllerB.swift
//  NavBarAnimation
//
//  Created by Tomasz Pietrowski on 16/01/2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

class ViewControllerB: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "B"
    extendedLayoutIncludesOpaqueBars = true
    view.backgroundColor = .yellow
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.setBackgroundImage(UIImage.fromColor(color: .yellow), for: .default)
  }
}
