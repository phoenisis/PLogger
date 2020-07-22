![Swift](https://github.com/phoenisis/PLogger/workflows/Swift/badge.svg)
# PLogger

### During Development: Colored Logging your Xcode Console
To help debugging your application, this package provide multiple logging level.
This library is matching `os_log` library from Apple and if your device is iOS 12 or MacOS 10.12 min, all logs are accessible from the App Console.

- 💙INFO
- 💜DEBUG
- 💚VERBOSE
- 🧡NOTICE
- ❤️ERROR
- 🖤FAULT

## Requirement 
- iOS 10
- MacOs 10.10

## Installation 
### Swift Package Manager

For [Swift Package Manager](https://swift.org/package-manager/) add the following package to your Package.swift file.

``` Swift
.package(url: "https://github.com/phoenisis/PLogger.git", .upToNextMajor(from: "1.0.0")),
```


## Usage

Add that near the top of your `AppDelegate.swift` to be able to use PLogger in your whole project.

``` Swift
import PLogger
let log = Plogger.self
```

## Function signatures

``` Swift 
log.info(_ message: Any, context: Any?, isPrivate: Bool = false)
log.debug(_ message: Any, context: Any?, isPrivate: Bool = false)
log.verbose(_ message: Any, context: Any?, isPrivate: Bool = false)
log.notice(_ message: Any, context: Any?, isPrivate: Bool = false)
log.error(_ message: Any, context: Any?, isPrivate: Bool = false)
log.fault(_ message: Any, context: Any?, isPrivate: Bool = false)

log.addFormater(_ formater: PLoggerErrorFormater)
log.changeLogOutput(debug: PLoggerOutputProtocol? = nil, release: PLoggerOutputProtocol?	= nil)
```

## Information
By default `isPrivate` is set to `false` witch will print log in production environement.
In DEBUG environement all logs are printed.

## Extension
### Formatter
You can add any error formater for your custom error, to do this you need to implement the `PLoggerErrorFormater`  protocol: 
``` Swift 
protocol PLoggerErrorFormater {
	func getErrorType() -> Any.Type
	func getErrorName() -> String
	func getErrorMessages(_ error: Error) -> [String: Any]
}
```
After implementing your own formatter you need to subscribe it in PLogger with the methode `addFormater(_ formater: PLoggerErrorFormater)`
``` Swift
let formatter: PLoggerErrorFormater = YourCustomPLoggerErrorFormater()
log.addFormater(formatter)
```

### Log output
You may want to change where logs are outputed like in a remote server or else, to do so PLogger provide a protocol that you may want to implemented: 
``` Swift
protocol PLoggerOutputProtocol {
	func actionFor(log: String, type: PLogger.LogType, isPrivate: Bool)
}
```

After implementing your own output action, you need to subscribe it in Plogger with the methode `changeLogOutput(debug: PLoggerOutputProtocol? = nil, release: PLoggerOutputProtocol? = nil)`
``` Swift
let outputActionForRelease: PLoggerOutputProtocol = YourCustomPLoggerErrorFormater()
log.changeLogOutput(release: outputActionForRelease)
```

---
## Exemples

### Extension 
An `AFError` extension is available as Exemple in `Sources/Plogger/Formatter Exemple`.

### Info
#### input
``` Swift
let array = ["a", "b", "c"]
		
log.info("A test")
log.info(array)
log.info("A test with array", context: array)
```

#### console output
``` Text
┌--- logger
|	- Date     : 2020-03-26 14:29:36 +0000
|	- Status   : 💙 Info
|	- Log      :
|		+ Message  : A test
└-------

┌--- logger
|	- Date     : 2020-03-26 14:29:36 +0000
|	- Status   : 💙 Info
|	- Log      :
|		+ Message  : ["a", "b", "c"]
└-------

┌--- logger
|	- Date     : 2020-03-26 14:29:36 +0000
|	- Status   : 💙 Info
|	- Log      :
|		+ Message  : A test with array
|		+ Context  : ["a", "b", "c"]
└-------
```

### Debug
#### input
``` Swift
let array = ["a", "b", "c"]
		
log.debug("A test")
log.debug(array)
log.debug("A test with array", context: array)
```

#### console output
``` Text
┌--- logger
|	- Date     : 2020-03-26 14:31:16 +0000
|	- Status   : 💜 Debug
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 20
|		+ Column   : 12
|	- Log      :
|		+ Message  : A test
└-------

┌--- logger
|	- Date     : 2020-03-26 14:31:16 +0000
|	- Status   : 💜 Debug
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 21
|		+ Column   : 12
|	- Log      :
|		+ Message  : ["a", "b", "c"]
└-------

┌--- logger
|	- Date     : 2020-03-26 14:31:16 +0000
|	- Status   : 💜 Debug
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 22
|		+ Column   : 12
|	- Log      :
|		+ Message  : A test with array
|		+ Context  : ["a", "b", "c"]
└-------
```

### verbose
#### input
``` Swift
let array = ["a", "b", "c"]
		
log.verbose("A test")
log.verbose(array)
log.verbose("A test with array", context: array)
```

#### console output
``` Text
┌--- logger
|	- Date     : 2020-03-26 14:32:35 +0000
|	- Status   : 💚 Verbose
|	- Thread   :
|		+ Stack size  : 524288
|		+ Priority    : 0.5
|		+ Name        : com.apple.main-thread
|		+ Executing   : true
|		+ Main Thread : true
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 20
|		+ Column   : 14
|	- Log      :
|		+ Message  : A test
└-------

┌--- logger
|	- Date     : 2020-03-26 14:32:35 +0000
|	- Status   : 💚 Verbose
|	- Thread   :
|		+ Stack size  : 524288
|		+ Priority    : 0.5
|		+ Name        : com.apple.main-thread
|		+ Executing   : true
|		+ Main Thread : true
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 21
|		+ Column   : 14
|	- Log      :
|		+ Message  : ["a", "b", "c"]
└-------

┌--- logger
|	- Date     : 2020-03-26 14:32:35 +0000
|	- Status   : 💚 Verbose
|	- Thread   :
|		+ Stack size  : 524288
|		+ Priority    : 0.5
|		+ Name        : com.apple.main-thread
|		+ Executing   : true
|		+ Main Thread : true
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 22
|		+ Column   : 14
|	- Log      :
|		+ Message  : A test with array
|		+ Context  : ["a", "b", "c"]
└-------
```

### verbose
#### input
``` Swift
let array = ["a", "b", "c"]
		
log.notice("A test")
log.notice(array)
log.notice("A test with array", context: array)
```

#### console output
``` Text
┌--- logger
|	- Date     : 2020-03-26 14:33:49 +0000
|	- Status   : 🧡 Notice
|	- Thread   :
|		+ Stack size  : 524288
|		+ Priority    : 0.5
|		+ Name        : com.apple.main-thread
|		+ Executing   : true
|		+ Main Thread : true
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 20
|		+ Column   : 14
|	- Log      :
|		+ Message  : A test
└-------

┌--- logger
|	- Date     : 2020-03-26 14:33:49 +0000
|	- Status   : 🧡 Notice
|	- Thread   :
|		+ Stack size  : 524288
|		+ Priority    : 0.5
|		+ Name        : com.apple.main-thread
|		+ Executing   : true
|		+ Main Thread : true
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 21
|		+ Column   : 14
|	- Log      :
|		+ Message  : ["a", "b", "c"]
└-------

┌--- logger
|	- Date     : 2020-03-26 14:33:49 +0000
|	- Status   : 🧡 Notice
|	- Thread   :
|		+ Stack size  : 524288
|		+ Priority    : 0.5
|		+ Name        : com.apple.main-thread
|		+ Executing   : true
|		+ Main Thread : true
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 22
|		+ Column   : 14
|	- Log      :
|		+ Message  : A test with array
|		+ Context  : ["a", "b", "c"]
└-------
```

### error
#### input
``` Swift
enum MyError: Error {
    case first(message: String)

    var localizedDescription: String { return "Some description here!" }
}
		
let error = MyError.first(message: "this is an error")
		
log.error("A test")
log.error(error)
log.error("A test with error", context: error)
```

#### console output
``` Text
┌--- logger
|	- Date     : 2020-03-26 14:43:59 +0000
|	- Status   : ❤️ Error
|	- Thread   :
|		+ Stack size  : 524288
|		+ Priority    : 0.5
|		+ Name        : com.apple.main-thread
|		+ Executing   : true
|		+ Main Thread : true
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 26
|		+ Column   : 12
|	- Log      :
|		+ Error    : 
|	A test
└-------

┌--- logger
|	- Date     : 2020-03-26 14:43:59 +0000
|	- Status   : ❤️ Error
|	- Thread   :
|		+ Stack size  : 524288
|		+ Priority    : 0.5
|		+ Name        : com.apple.main-thread
|		+ Executing   : true
|		+ Main Thread : true
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 27
|		+ Column   : 12
|	- Log      :
|		+ Error    : 
|			+ Localized : The operation couldn’t be completed. (test.MyError error 0.)
|			+ error     : first(message: "this is an error")
└-------

┌--- logger
|	- Date     : 2020-03-26 14:43:59 +0000
|	- Status   : ❤️ Error
|	- Thread   :
|		+ Stack size  : 524288
|		+ Priority    : 0.5
|		+ Name        : com.apple.main-thread
|		+ Executing   : true
|		+ Main Thread : true
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 28
|		+ Column   : 12
|	- Log      :
|		+ Error    : 
A test with error
|		+ Context  : first(message: "this is an error")
└-------
```

### fault
#### input
``` Swift
enum MyError: Error {
	case first(message: String)
	var localizedDescription: String {
		return "Some description here!"
	}
}

let error = MyError.first(message: "this is an error")

log.fault("A test")
log.fault(error)
log.fault("A test with error", context: error)
```

#### console output
``` Text
┌--- logger
|	- Date     : 2020-03-26 14:43:59 +0000
|	- Status   : 🖤 Fault
|	- Thread   :
|		+ Stack size  : 524288
|		+ Priority    : 0.5
|		+ Name        : com.apple.main-thread
|		+ Executing   : true
|		+ Main Thread : true
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 26
|		+ Column   : 12
|	- Log      :
|		+ Error    : 
|	A test
└-------

┌--- logger
|	- Date     : 2020-03-26 14:43:59 +0000
|	- Status   : 🖤 Fault
|	- Thread   :
|		+ Stack size  : 524288
|		+ Priority    : 0.5
|		+ Name        : com.apple.main-thread
|		+ Executing   : true
|		+ Main Thread : true
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 27
|		+ Column   : 12
|	- Log      :
|		+ Error    : 
|			+ Localized : The operation couldn’t be completed. (test.MyError error 0.)
|			+ error     : first(message: "this is an error")
└-------

┌--- logger
|	- Date     : 2020-03-26 14:43:59 +0000
|	- Status   : 🖤 Fault
|	- Thread   :
|		+ Stack size  : 524288
|		+ Priority    : 0.5
|		+ Name        : com.apple.main-thread
|		+ Executing   : true
|		+ Main Thread : true
|	- File     :
|		+ Name     : ViewController.swift
|		+ Function : viewDidLoad()
|		+ Line     : 28
|		+ Column   : 12
|	- Log      :
|		+ Error    : 
|	A test with error
|		+ Context  : first(message: "this is an error")
└-------
```
