# JXUtils

[![CI Status](https://img.shields.io/travis/oojlxavier@gmail.com/JXUtils.svg?style=flat)](https://travis-ci.org/oojlxavier@gmail.com/JXUtils)
[![Version](https://img.shields.io/cocoapods/v/JXUtils.svg?style=flat)](https://cocoapods.org/pods/JXUtils)
[![License](https://img.shields.io/cocoapods/l/JXUtils.svg?style=flat)](https://cocoapods.org/pods/JXUtils)
[![Platform](https://img.shields.io/cocoapods/p/JXUtils.svg?style=flat)](https://cocoapods.org/pods/JXUtils)

This project was created with the intent of removing common and weird boiler plate code writed in a myriad of iOS applications, such as presenting simple Alerts, instantiating UIViews from Nib, setting Gradients, and so on.. Feel free to open any issues or pull requests.

## Capabilities
The examples below uses the default params as implementation, but you can see the full list of params for each method in the methods declarations.

<!--### TOPIC:-->
<!--- Capability-->
<!--#### Examples:-->
<!--```swift-->
<!--//CODE-->
<!--```-->

### UIDevice:
- Easier way to found if is iPad/iPhone
- Easier way to found if it is in landscape or portrait orientation
#### Examples:
```swift
let isIPad = UIDevice.isPad()
let isIPhone = UIDevice.isPhone()
let isPortrait = UIDevice.isPortrait()
let isLandscape = UIDevice.isLandscape()
```

### Vector Operations:
- Various vector operations and useful properties are added to any type that conforms to the protocol CSVector2Protocol (such as CGPoint and CGSize).
#### Examples:
```swift
struct CustomVector2: CSVector2Protocol {
var x: CSScalar
var y: CGScalar

static func constructFromVector(_ vector: CSVector2) -> Vector2 {
return Vector2.init(x: vector.x, y: vector.y)
}
}

let vector = CustomVector2(x:10,y:20)
print(vector * 2) // Output: CustomVector2(x:20,y:40)
print(vector / 2) // Output: CustomVector2(x:5,y:10)
print(vector / vector) // Output: CustomVector2(x:1,y:1)
print(vector * vector) // Output: CustomVector2(x:100,y:400)
print(-vector) // Output: CustomVector2(x:-10,y:-20)
//And various others...
```

### Sequence:
- Some useful methods to verify conditions on the sequence (none, any, all)
- Count where
#### Examples:
```swift
let list = [1,2,3,4,5,6]

let isAllPositive = list.none({$0 < 0}) // Output: true
let hasNegative = list.any({$0 < 0}) // Output: false
let allLessThan10 = list.all({$0 < 10}) // Output: true

let evenNumbers = list.count({ $0 % 2 == 0 }) // Output: 3

```

### UIViewController:
- Easier way for instantiating a ViewController from Storyboard;
- Easier method to present an Alert;
##### Examples:
```swift

// Instantiate the LoginViewController from the Storyboard with name 'Login.storyboard', and with the identifier 'LoginViewController'
// If in the Storyboard there is no viewController with this identifier, the Initial viewController will be instantiated instead.
let viewController: LoginViewController = LoginViewController.fromStoryboard()

//Instantiate the UINavigationController from the initial viewController of the Storyboard with name 'Login.storyboard'
let navigationController: UINavigationController = LoginViewController.fromStoryboardWithNavigationController() 

// Will present an UIAlertController with the inputed message, no title, no cancel button and with the button "Close".
UIViewController().showAlert(title: nil, message: "You did the thing with success!", actions: [CSUIViewControllerSettings.defaultAlertCloseAction()])

// Same as the the previous example.
UIViewController().showMessage(message:"You did the thing with success!")

// To modify some of the default behaviors, such as the Close and Cancel Actions (from showMessage) and the
// Storyboard naming pattern (used in fromStoryboard()), you can change the static closures of the CSUIViewControllerSettings structure.

```

### NSObject:
- Easier way to get the class's name of the Type or Instance.
#### Examples:
```swift
print(CustomType.className) // Output: "CustomType"
print(CustomType().className) // Output: "CustomType"
```

### UIView:
- Easier way to instantiate a UIView from Nib.
#### Examples:
```swift
// Instantiate the UIView of the type CustomView from the nib named 'CustomView'
let view = CustomView.fromNib()
```

### CGRect + CGPoint + CGSize:
- Easier constructors
- Easy way of changing properties with declarative style
- Multiple math operations added to CGPoint and CGSize (CGRect will receive them in the near future)
#### Examples:
```swift
let frame = CGRect.zero.with(x:100, y:10, width: 10).adding(onX:50, onHeight:100) //Output: CGRect(x:150, y:10, width:10, height:100)
let frame2 = frame.with(origin: frame.origin / 2) //Output: CGRect(x:75, y:5, width:10, height:100)
let frame3 = frame.with(size: frame.size * 2) //Output: CGRect(x:150, y:10, width:20, height:200)
```

### CALayer:
- Easier way to insert gradients
#### Examples:
```swift
self.layer.insertGradient(from: .bottom, to: .top, with: [UIColor.black, UIColor.white], distribution: .fibonacci) //Returns the CAGradientLayer after insertion, but the result is discardable.
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

CupertinoStandards is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CupertinoStandards'
```

## Author

MrJorgeXavier

## License

CupertinoStandards is available under the MIT license. See the LICENSE file for more info.
