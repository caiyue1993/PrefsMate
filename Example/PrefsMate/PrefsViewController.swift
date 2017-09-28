//
//  ViewController.swift
//  PrefsMate
//
//  Created by caiyue1993 on 09/26/2017.
//  Copyright © 2017 Nanjing University. All rights reserved.
//

import UIKit
import PrefsMate

class PrefsViewController: UIViewController {
    
    private let pListUrl: URL
    private lazy var tableView: PrefsTableView = {
        return Mate.createPrefsTableView()
    }()
    
    init(with pListUrl: URL) {
        self.pListUrl = pListUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        Mate.parseWithSource(self, plistUrl: pListUrl) {
            tableView.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension PrefsViewController: PrefsSupportable {
    var switchableItems: [String : SwitchableItemHandler]? {
        return [
            "handleTheme": { isOn in print(isOn)}
        ]
    }
    
    var selectableItems: [String : SelectableItemHandler]? {
        return [
            "jumpToSetNewIcon": { print("U r the best") }
        ]
    }
}

