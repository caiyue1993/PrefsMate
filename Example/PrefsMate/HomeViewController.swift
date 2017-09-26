//
//  HomeViewController.swift
//  PrefsMate_Example
//
//  Created by 蔡越 on 26/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var demoButton: UIButton = {
        let b = UIButton()
        b.setTitle("JUMP TO NEXT", for: .normal)
        b.setTitleColor(UIColor.black, for: .normal)
        b.addTarget(self, action: #selector(nav), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(demoButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        demoButton.center = view.center
        demoButton.sizeToFit()
    }
    
    func nav(){
        let vc = PrefsViewController(with: Bundle.main.url(forResource: "Prefs", withExtension: "plist")!)
        navigationController?.pushViewController(vc, animated: true)
    }

}
