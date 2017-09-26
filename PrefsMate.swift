//
//  Mate.swift
//  PrefsMate
//
//  Created by 蔡越 on 26/09/2017.
//

import Foundation

public typealias PrefsTableView = UITableView
public let Mate = PrefsMate.default

open class PrefsMate: NSObject {
    
    open static let `default` = PrefsMate()
    
    var prefs: [[Pref]] = [[]]
    var prefsPListLocation: URL!
    
    var target: NSObject!
    
    public func create(with pListUrl: URL, target: NSObject) -> PrefsTableView {
        prefsPListLocation = pListUrl
        self.target = target
        
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView(frame: .zero)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }
    
    public func parse(completionClosure: (() -> Void))  {
        let decoder = PropertyListDecoder()
        let data = try! Data(contentsOf: prefsPListLocation)
        prefs = try! decoder.decode([[Pref]].self, from: data)
        completionClosure()
    }
    
}

extension PrefsMate: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pref = prefs[indexPath.section][indexPath.row]
        target.perform(ActionMapper.action(of: pref.actionName))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PrefsMate: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return prefs.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prefs[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let pref = prefs[indexPath.section][indexPath.row]
        cell.textLabel?.text = pref.title
        cell.accessoryType = pref.hasDisclosure ? .disclosureIndicator : .none
        cell.hasSwitch = pref.hasSwitcher
        cell.switchClosure = {
            pref.hasSwitcher = $0
        }
        return cell
    }
}


