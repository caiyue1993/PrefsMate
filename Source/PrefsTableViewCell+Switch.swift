//
//  UITableViewCell+Switch.swift
//  Mate
//
//  Created by 蔡越 on 25/09/2017.
//  Copyright © 2017 Nanjing University. All rights reserved.
//

import Foundation
import UIKit

struct AssociateKeys {
    static var switchClosureKey = 0
}

extension PrefsTableViewCell {
    var hasSwitch: Bool {
        set {
            if newValue {
                let `switch` = UISwitch()
                `switch`.addTarget(self, action: #selector(switchAction(_:)), for: .valueChanged)
                accessoryView = `switch`
            }
        }
        get {
            return false
        }
    }
    
    var switchStatus: Bool {
        set {
            if newValue {
                if let av = (accessoryView as? UISwitch) {
                    av.setOn(newValue, animated: false)
                }
            }
        }
        get {
            return false
        }
    }
    
    var switchClosure: ((Bool) -> Void)? {
        set {
            objc_setAssociatedObject(self, &AssociateKeys.switchClosureKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &AssociateKeys.switchClosureKey) as! ((Bool) -> Void)?
        }
    }
    
    @objc func switchAction(_ sender: UISwitch) {
        if let closure = switchClosure {
            closure(sender.isOn)
        } else {
            fatalError("Switch closure undefined.")
        }
    }
}
