//
//  NavigationBar.swift
//  NavBarAnimation
//
//  Created by Alex Demishkevich on 1/24/18.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {

  override func pushItem(_ item: UINavigationItem, animated: Bool) {
    return super.pushItem(item, animated: false)
  }

  override func popItem(animated: Bool) -> UINavigationItem? {
    return super.popItem(animated: false)
  }
}
