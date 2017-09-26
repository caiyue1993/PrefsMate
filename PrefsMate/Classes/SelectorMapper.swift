//
//  SelectorMapper.swift
//  Mate
//
//  Created by 蔡越 on 25/09/2017.
//  Copyright © 2017 Nanjing University. All rights reserved.
//

import Foundation

public class ActionMapper: NSObject {
    
    static func action(of name: String) -> Selector {
        return NSSelectorFromString(name)
    }
    
}
