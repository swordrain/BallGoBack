//
//  ViewController.swift
//  BallGoBack
//
//  Created by lianli on 16/12/2.
//  Copyright © 2016年 lianli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let WIDTH : CGFloat = 50
    let HEIGHT : CGFloat = 50
    let TOP: CGFloat = 50
    let LEFT: CGFloat = 50
    
    var topConstraint: NSLayoutConstraint!
    var leftConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupView()
    }
    
    private func setupView(){
        
        view.backgroundColor = UIColor.cyan
        //create ball
        let ball = UIView()
        ball.backgroundColor = UIColor.red
        ball.layer.cornerRadius = 25
        ball.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(ball)
        
        //autolayout
        
        let widthConstraint = NSLayoutConstraint(item: ball, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: WIDTH)
        let heightConstraint = NSLayoutConstraint(item: ball, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: HEIGHT)
        
        topConstraint = NSLayoutConstraint(item: ball, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: TOP)
        leftConstraint = NSLayoutConstraint(item: ball, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: LEFT)
        
        self.view.addConstraints([widthConstraint, heightConstraint, topConstraint, leftConstraint])
        
        //gesture
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(pan))
        ball.addGestureRecognizer(gesture)
    }
    
    
    func pan(gesture: UIPanGestureRecognizer){
        if(gesture.state == .ended){
            topConstraint.constant = TOP
            leftConstraint.constant = WIDTH
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            return
        }
        let point = gesture.translation(in: self.view)
        gesture.setTranslation(CGPoint.zero, in: self.view) //需要reset，否则是每次移动的增量而不是相对于初始移动时的增量
        
        leftConstraint.constant = leftConstraint.constant + point.x
        topConstraint.constant = topConstraint.constant + point.y
        //print(left.constant)
        //print(top.constant)
        self.view.layoutIfNeeded()
    }
    
    
}

