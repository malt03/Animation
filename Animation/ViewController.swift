//
//  ViewController.swift
//  Animation
//
//  Created by Koji Murata on 2015/08/04.
//  Copyright © 2015年 Koji Murata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    private var topConstraintConstantWhenBegan = CGFloat(0)
    private let minTopConstraintConstant = CGFloat(0)
    private var maxTopConstraintConstant: CGFloat {
        get { return view.frame.height - 50 - topLayoutGuide.length }
    }
    
    @IBAction func panned(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Began:
            topConstraintConstantWhenBegan = topConstraint.constant
        case .Changed:
            topConstraint.constant = sender.translationInView(view).y + topConstraintConstantWhenBegan
        case .Ended:
            let velocity = sender.velocityInView(view).y
            let beforeConstant = topConstraint.constant
            let afterConstant = velocity > 0 ? maxTopConstraintConstant : minTopConstraintConstant
            let distance = afterConstant - beforeConstant
            topConstraint.constant = afterConstant
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: velocity / distance, options: .CurveLinear, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        default: break
        }
    }
}