//
//  ViewController.swift
//  PrefsMate
//
//  Created by caiyue1993 on 09/26/2017.
//  Copyright (c) 2017 caiyue1993. All rights reserved.
//

import UIKit
import PrefsMate

class PrefsViewController: UIViewController {
    
    private let pListUrl: URL
    private var tableView: PrefsTableView!
    
    init(with pListUrl: URL) {
        self.pListUrl = pListUrl
        super.init(nibName: nil, bundle: nil)
        self.tableView = Mate.create(with: pListUrl, target: self),
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        Mate.parse {
            tableView.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension PrefsViewController {
    @objc func jumpToSetNewIcon() {
        
    }
}

