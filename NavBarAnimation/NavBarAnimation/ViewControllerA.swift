//
//  ViewControllerA.swift
//  NavBarAnimation
//
//  Created by Tomasz Pietrowski on 16/01/2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

class ViewControllerA: UIViewController, UINavigationControllerDelegate {
    
    override func loadView() {
        super.loadView()
        title = "A"
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = .lightGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "NEXT",
            style: .plain,
            target: self,
            action: #selector(showController)
        )
        
        navigationController?.delegate = self
        navigationController?.navigationBar.setBackgroundImage(UIImage.fromColor(color: .lightGray), for: .default)
    }
    
    @objc func showController() {
        let vc = ViewControllerB()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransition(isPresenting: operation == .push)
    }
}
