//
//  Mate.swift
//  PrefsMate
//
//  Created by 蔡越 on 26/09/2017.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

public typealias PrefsTableView = UITableView

/// 

open class PrefsMate: NSObject {
    
    /// A nested array to store parsed prefs and to render table view
    private(set) var prefs: [[Pref]] = [[]]
    
    /// A url to store plist file location
    private var plistUrl: URL!
    
    /// A NSObject to store the outer object. Cuz it will perform selector outside, we need a property to hold the reference of them
    private(set) var target: NSObject!
    
    
    // MARK: - Singleton
    
    /// Returns a default PrefsMate. A global constant `Mate` is a shortcut of `PrefsMate.default`.
    ///
    /// - seealso: `Mate`
    open static let `default` = PrefsMate()
    
    
    // MARK: - Functions that exposed to outside world
    
    /// Create a PrefsTableView purely
    open func createPrefsTableView() -> PrefsTableView {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView(frame: .zero)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }
    
    /// Parse a plist file and ready to do some rendering in completion
    ///
    /// - parameter target: the seletor that should be performed on. Usually if you are accustomed to write @objc func in the same
    ///     view controller, pass `self`
    /// - parameter plistUrl: the url that the plist file locates
    /// - parameter completion: as the name indicates
    open func parse(with target: NSObject,
                    plistUrl: URL,
                    completion: (() -> Void))  {
        self.target = target
        self.plistUrl = plistUrl
        let decoder = PropertyListDecoder()
        let data = try! Data(contentsOf: plistUrl)
        prefs = try! decoder.decode([[Pref]].self, from: data)
        completion()
    }
    
    
    func writePList() {
        let encoder = PropertyListEncoder()
        let data = try! encoder.encode(prefs)
        try! data.write(to: plistUrl)
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
        cell.switchClosure = { [weak self] in
            pref.hasSwitcher = $0
            guard let `self` = self else { return }
            `self`.writePList()
        }
        return cell
    }
    
}

// MARK: - Default PrefsMate
public let Mate = PrefsMate.default
