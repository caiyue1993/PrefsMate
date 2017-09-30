# PrefsMate

[![CI Status](http://img.shields.io/travis/caiyue1993/PrefsMate.svg?style=flat)](https://travis-ci.org/caiyue1993/PrefsMate)
[![Version](https://img.shields.io/cocoapods/v/PrefsMate.svg?style=flat)](http://cocoapods.org/pods/PrefsMate)
[![License](https://img.shields.io/cocoapods/l/PrefsMate.svg?style=flat)](http://cocoapods.org/pods/PrefsMate)
[![Platform](https://img.shields.io/cocoapods/p/PrefsMate.svg?style=flat)](http://cocoapods.org/pods/PrefsMate)

PrefsMate provide an elegant way to generate UITableView using a property list file(plist file, in short). Also, you can configure actions. Thanks to the **Codable** protocol in Swift 4, it makes the code perfect clean.

## Background

In our app, we usually need a UITableView in PrefsViewController(or perhaps named SettingsViewController, whatever). And the interface may just looks like this:

![PrefsViewController](https://i.loli.net/2017/09/29/59cdab5adb4f4.png)

When implementing this kind of stuff, your inner voice must be saying: "Writing this UI is fxxking tedious! Is there any help that I can ask for?" 

And congrats! You have come to the right place :).  

## Preparation 

## 1. Prepare a plist file containing formatted data 

Taking example of the image above, the formatted plist file looks like this:

![plist structure](https://i.loli.net/2017/09/29/59cdb7a32ed93.png)

(Don't be afraid of this long file. In fact you just need to do some clickable things.) 

## 2. Create the table view and do the parsing job
```swift
let tableView = Mate.createPrefsTableView()
```

You can add the parsing code in viewDidLoad():
```swift
 do {
      try Mate.parseWithSource(self, plistUrl: pListUrl) {
        tableView.reloadData()
      }
    } catch {
        // Handle with the error
    }
```

## 3. Make your view controller conform to PrefsSupportable protocol

Cuz we have the need to customize select actions and switch actions, PrefsSupportable protocol is provided. 

```swift
public protocol PrefsSupportable {
    /// Return a bunch of switchableItems, including their behavior in SwitchableItemHandler.
    var switchableItems: [SwitchActionName: SwitchableItemHandler]? { get }
    
    /// Return a bunch of selectableItems, including their behavior in SelectableItemHandler.
    var selectableItems: [SelectActionName: SelectableItemHandler]? { get }
}
```

Taking the switch of night theme for example:

```swift
var switchableItems: [SwitchActionName : SwitchableItemHandler]? {
        return [
            "handleThemeMode": { isOn in
                print("Dark theme mode is \(isOn)")
            }
        ]
}
```

Then we are done! PrefsMate will do right things.

> Be cautious, the "handleThemeMode" String must be the same value of `switchActionName` in the plist file. Same on `selectActionName`.

You could refer to [Example project](https://github.com/caiyue1993/PrefsMate/tree/master/Example) for more detail.

## 4. Enjoy 

Once following the rules above, you are all set! We handle the data persistence for you.:)

Enjoy yourself. 

## Suggestions

- Being familiar with plist file will help you a lot. Sometimes you can directly edit the plist file through "Open As Source Code". 

- Explore the source code!

- If you have an issue, please don't hesitate. Just let me know :)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory.

(Cuz this is a new Pod, you may need to `pod update` first.)

## Requirements

- Swift 4
- iOS 9 or later

## Installation

PrefsMate is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PrefsMate'
```

## Contact

- Weibo: [@CaiYue_](http://weibo.com/caiyue233)
- Twitter: [@caiyue5](https://twitter.com/caiyue5)

## License

PrefsMate is available under the MIT license. See the LICENSE file for more info.
