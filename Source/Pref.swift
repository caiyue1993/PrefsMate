//
//  Pref.swift
//  Mate
//
//  Created by 蔡越 on 25/09/2017.
//  Copyright © 2017 Nanjing University. All rights reserved.
//

import Foundation

class Pref: Codable {
    let title: String
    let actionName: String
    let hasSwitch: Bool
    var switchStatus: Bool
    let switchActionName: String
    let hasDisclosure: Bool
}


