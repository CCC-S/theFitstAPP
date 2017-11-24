//
//  FirstViewController.swift
//  EXERCISE2
//
//  Created by empcjs chin on 2017/11/17.
//  Copyright © 2017年 empcjs chin. All rights reserved.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {
    
    //var imageView: UIView!
    
    let imageSet = ["1.JPEG","2.JPEG","3.JPEG","4.JPEG","5.JPEG"];
    var indexOfImage = 0
    
    let imageView = UIImageView(frame:CGRect(x:10,y:70,width:300,height:300))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel(frame: CGRect(x: 40, y: 150, width: 240, height: 44))
        label.text = "The First Page."
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Arial", size: 23)
        self.view.addSubview(label)
        self.view.backgroundColor = UIColor.white
        
        
        imageView.image = UIImage(named:imageSet[indexOfImage])
        //imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = true
        
        self.view.addSubview(imageView)
        
        // 拖曳手勢
        let pan = UIPanGestureRecognizer(target:self,action:#selector(FirstViewController.pan))
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        //imageView.addGestureRecognizer(pan)
        
        //缩放手势
        let pinch = UIPinchGestureRecognizer(target:self,action:#selector(FirstViewController.pinch))
        imageView.addGestureRecognizer(pinch)
        
        // 向左滑動
        let swipeLeft = UISwipeGestureRecognizer(target:self,action:#selector(FirstViewController.swipe))
        swipeLeft.direction = .left
        imageView.addGestureRecognizer(swipeLeft)
        
        // 向右滑動
        let swipeRight = UISwipeGestureRecognizer(target:self,action:#selector(FirstViewController.swipe))
        swipeRight.direction = .right
        imageView.addGestureRecognizer(swipeRight)
    }
    
    @objc
    func swipe(recognizer:UISwipeGestureRecognizer) {
        
        if recognizer.direction == .right {
            indexOfImage = (indexOfImage + 1) % imageSet.capacity
            imageView.image = UIImage(named:imageSet[indexOfImage])
        }
        else if recognizer.direction == .left{
            indexOfImage = (indexOfImage - 1 + imageSet.count) % imageSet.count
            imageView.image = UIImage(named:imageSet[indexOfImage])
        }
        
        
    }
        
    
    @objc
    func pan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let myView = recognizer.view {
            myView.center = CGPoint(x: myView.center.x + translation.x, y: myView.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }
    
    @objc
    func pinch(recognizer:UIPinchGestureRecognizer) {
        let imageView = recognizer.view
        if recognizer.state == .changed {
            // 圖片原尺寸
            let frm = imageView?.frame
            // 縮放比例
            let scale = recognizer.scale
            // 目前圖片寬度
            let w = frm?.width
            // 目前圖片高度
            let h = frm?.height
            // 縮放比例的限制為 0.5 ~ 2 倍
            if w! * scale > 100 && w! * scale < 400 {
                imageView!.frame = CGRect(
                    x: frm!.origin.x, y: frm!.origin.y,
                    width: w! * scale, height: h! * scale)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
