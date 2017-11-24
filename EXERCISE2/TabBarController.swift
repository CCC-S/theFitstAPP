//
//  TabBarController.swift
//  EXERCISE2
//
//  Created by empcjs chin on 2017/11/17.
//  Copyright © 2017年 empcjs chin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstViewController = FirstViewController()
        let secondViewController = SecondViewController()
        let thirdViewController = ThirdViewController()
        
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.favorites, tag: 1)
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 2)
        thirdViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.more, tag: 3)
        
        self.viewControllers = [firstViewController, secondViewController, thirdViewController]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
