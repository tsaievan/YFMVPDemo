//
//  YFBaseViewController.swift
//  YFMVPDemo
//
//  Created by tsaievan on 2017/11/6.
//  Copyright © 2017年 tsaievan. All rights reserved.
//

import UIKit

@objc protocol YFBaseViewControllerProtocol {
    
    @objc optional func initViews()
    
    @objc optional func setupConstrints()
    
    @objc optional func popBackVC()
    
    @objc optional func dismissVC()
}

class YFBaseViewController: UIViewController, YFBaseViewControllerProtocol {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func popBackVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("%s",#function)
    }

}
