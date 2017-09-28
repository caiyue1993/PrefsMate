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

/// PrefsMate provides an elegant way to generate PrefsViewController(or may be SettingsViewController) in your app. All you
/// need is a structured plist file. As for the other things, PrefsMate handles for you.
/// For more reference, navigate to http://
open class PrefsMate: NSObject {
    
    /// A nested array to store parsed prefs and to render table view
    private(set) var prefs: [[Pref]] = [[]]
    
    /// A url to store plist file location
    private var plistUrl: URL!
    
    /// A NSObject to store the outer object. Cuz it will perform selector outside, we need a property to hold the reference of them
    private(set) var source: NSObject!
    
    
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
    /// - parameter source: the seletor that should be performed on. Usually if you are accustomed to write @objc func in the same
    ///     view controller, pass `self`
    /// - parameter plistUrl: the url that the plist file locates
    /// - parameter completion: as the name indicates
    open func parseWithSource(_ source: NSObject,
                              plistUrl: URL,
                              completion: (() -> Void)) throws {
        self.source = source
        self.plistUrl = plistUrl
        
        let data = try Data(contentsOf: plistUrl)
        let decoder = PropertyListDecoder()
        do {
            prefs = try decoder.decode([[Pref]].self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Missing key: \(key)")
            print("Debug description: \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("Missing value for type: \(type)")
            print("Debug description: \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type mismatch for type: \(type)")
            print("Debug description: \(context.debugDescription)")
        } catch {
            print(error.localizedDescription)
        }
        completion()
    }
    
    private func writePList() throws {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(prefs)
            try data.write(to: plistUrl)
        } catch EncodingError.invalidValue(let value, let context) {
            print("Invalid value: \(value)")
            print("Debug description: \(context.debugDescription)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension PrefsMate: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let source = source as? PrefsSupportable else {
            fatalError("You have to implement PrefsSupportable protocol")
        }
        
        let pref = prefs[indexPath.section][indexPath.row]
        
        if let selectableItems = source.selectableItems, let selectAction = selectableItems[pref.actionName] {
            selectAction()
        } else {
            print("Go and check it, you may mistype the actionName \(pref.actionName)")
        }
        
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
        guard let source = source as? PrefsSupportable else {
            fatalError("You have to implement PrefsSupportable protocol")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let pref = prefs[indexPath.section][indexPath.row]
        cell.textLabel?.text = pref.title
        cell.accessoryType = pref.hasDisclosure ? .disclosureIndicator : .none
        cell.hasSwitch = pref.hasSwitch
        cell.switchStatus = pref.switchStatus
        
        cell.switchClosure = { [weak self] isOn in
            if let switchableItems = source.switchableItems, let switchAction = switchableItems[pref.switchActionName] {
                switchAction(isOn)
            } else {
                print("You may mismatch the switchActionName \(pref.switchActionName) in plist file and PrefsSupportable implementation, go and check it" )
            }
            pref.switchStatus = isOn
            guard let `self` = self else { return }
            try? `self`.writePList()
        }
        
        return cell
    }
    
}

// MARK: - Default PrefsMate
public let Mate = PrefsMate.default
