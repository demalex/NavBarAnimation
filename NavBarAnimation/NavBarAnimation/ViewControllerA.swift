//
//  ViewControllerA.swift
//  NavBarAnimation
//
//  Created by Tomasz Pietrowski on 16/01/2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

class ViewControllerA: UIViewController, UINavigationControllerDelegate {
    
    @objc func showController() {
        let vc = ViewControllerB()
        navigationController?.pushViewController(vc, animated: true)
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "A"
    view.backgroundColor = .lightGray
    extendedLayoutIncludesOpaqueBars = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "NEXT",
      style: .plain,
      target: self,
      action: #selector(showController)
    )
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.setBackgroundImage(UIImage.fromColor(color: .lightGray), for: .default)
  }
}
