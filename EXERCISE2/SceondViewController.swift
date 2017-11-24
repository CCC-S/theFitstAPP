//
//  SceondViewController.swift
//  EXERCISE2
//
//  Created by empcjs chin on 2017/11/17.
//  Copyright © 2017年 empcjs chin. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    let imageView = UIImageView(frame:CGRect(x:10,y:70,width:300,height:300))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let label = UILabel(frame: CGRect(x: 40, y: 150, width: 240, height: 44))
        label.text = "The Second Page."
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Arial", size: 23)
        
        self.view.addSubview(label)
        self.view.backgroundColor = UIColor.white
        
        imageView.image = UIImage(named: "g.png");
        imageView.isUserInteractionEnabled = true
        self.view.addSubview(imageView)
        
        let pan = UIPanGestureRecognizer(target:self,action:#selector(self.pan))
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        imageView.addGestureRecognizer(pan)
    }
    
    @objc
    func pan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let myView = recognizer.view {
            myView.center = CGPoint(x: myView.center.x + translation.x, y: myView.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
