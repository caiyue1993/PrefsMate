//
//  ViewController.swift
//  PrefsMate
//
//  Created by 蔡越 on 09/26/2017.
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
        do {
            try Mate.parseWithSource(self, plistUrl: pListUrl) {
                tableView.reloadData()
            }
        } catch {
            // Handle with error
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension PrefsViewController: PrefsSupportable {
    var switchableItems: [SwitchActionName : SwitchableItemHandler]? {
        return [
            "handleThemeMode": { isOn in
                print("Dark theme mode is \(isOn)")
            }
        ]
    }
    
    var selectableItems: [SelectActionName : SelectableItemHandler]? {
        return [
            "changeIcon": {
                print("Go to icon change view controller")
            },
            "mailAction": {
                print("Handle with mail action")
            },
            "twitterAction": {
                print("Handle with twitter action")
            },
            "weiboAction": {
                print("Handle with weibo action")
            },
            "rankAction": {
                print("Handle with rank action")
            },
            "thankAction": {
                print("Handle with thank action")
            }
        ]
    }
}

