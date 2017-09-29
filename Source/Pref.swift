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
    let selectActionName: String
    let hasSwitch: Bool
    var switchStatus: Bool
    let switchActionName: String
    let hasDisclosure: Bool
    let detailText: String
}

class SectionOfPrefs: Codable {
    var prefs: [Pref]
    let header: String
    let footer: String
}
