//
//  PrefsSupportable.swift
//  PrefsMate
//
//  Created by 蔡越 on 28/09/2017.
//

import Foundation

public typealias SwitchableItemHandler = ((Bool) -> Void)
public typealias SelectableItemHandler = (() -> Void)

public typealias SwitchActionName = String
public typealias SelectActionName = String

/// A type that give a hand to PrefsMate
///
/// - seealso: `PrefsMate`
public protocol PrefsSupportable {
    
    /// Return a bunch of switchableItems, including their behavior in SwitchableItemHandler.
    var switchableItems: [SwitchActionName: SwitchableItemHandler]? { get }
    
    /// Return a bunch of selectableItems, including their behavior in SelectableItemHandler.
    var selectableItems: [SelectActionName: SelectableItemHandler]? { get }
    
}
