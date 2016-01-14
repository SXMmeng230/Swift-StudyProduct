//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//10-属性
import UIKit

var str = "Hello, playground"

//属性是描述特定类、结构或者枚举的值。存储属性作为实例的一部分存储常量与变量的值，而计算属性计算他们的值（不只是存储）。计算属性存在于类、结构与枚举中。存储属性仅仅只在类与结构中。
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
1、存储属性
最简单的情形，作为特定类或结构实例的一部分，存储属性存储着常量或者变量的值。存储属性可分为变量存储属性（关键字var描述）和常量存储属性（关键字let描述）
*/
//下面的例子定义了一个叫FixedLengthRange的结构，它描述了一个一定范围内的整数值，当创建这个结构时，范围长度是不可以被改变的
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6

//常量结构实例的存储属性
//如果你创建一个结构实例，并将其赋给一个常量，这个实例中的属性将不可以被改变，即使他们被声明为变量属性

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// this range represents integer values 0, 1, 2, and 3
//rangeOfFourItems.firstValue = 6  
//因为rangeOfFourItems是一个常量（let），即便firstValue是一个变量属性，它的值也是不可以被改变的

//Lazy Stored Properties（懒惰存储属性？）
//懒惰存储属性是当它第一次被使用时才进行初值计算。通过在属性声明前加上@lazy来标识一个懒惰存储属性。
//注意
//必须声明懒惰存储属性为变量属性（通过var），因为它的初始值直到实例初始化完成之后才被检索。常量属性在实例初始化完成之前就应该被赋值，因此常量属性不能够被声明为懒惰存储属性。

class DataImaporter {
    var fileName = "Sun"
}
class DataManager {
    lazy var importer = DataImaporter()
    var data = [String]()
}
let manager = DataManager()
manager.data += ["some"]
manager.data += ["some more"]
print(manager.data)

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2、计算属性
除了存储属性，类、结构和枚举能够定义计算属性。计算属性并不存储值，它提供getter和可选的setter来间接地获取和设置其它的属性和值。
*/
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

//setter声明的简略写法
//如果计算属性的setter方法没有将被设置的值定义一个名称，将会默认地使用newValue这个名称来代替。下面的例子采用了这样一种特性，定义了Rect结构的新版本：
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
//只读计算属性
//只读计算属性只带有一个getter方法，通过点操作符，可以放回属性值，但是不能修改它的值。
//注意
//应该使用var关键字将计算属性－包含只读计算属性－定义成变量属性，因为它们的值并不是固定的。let关键字只被常量属性说使用，以表明一旦被设置它们的值就是不可改变的了
//通过移除get关键字和它的大括号，可以简化只读计算属性的定义：
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
3、属性观察者
属性观察者观察属性值的改变并对此做出响应。当设置属性的值时，属性观察者就被调用，即使当新值同原值相同时也会被调用。
*/
//除了懒惰存储属性，你可以为任何存储属性加上属性观察者定义。另外，通过重写子类属性，也可以继承属性（存储或计算）加上属性观察者定义。
//注意 : 不必为未重写的计算属性定义属性观察者，因为可以通过它的setter方法直接对值的改变做出响应
/*
定义属性的观察者时，你可以单独或同时使用下面的方法：
willSet：设置值前被调用
didSet：设置值后立刻被调用
当实现willSet观察者时，新的属性值作为常量参数被传递。你可以为这个参数起一个名字，如果不的话，这个参数就默认地被命名成newValue。
在实现didSet观察者时也是一样，只不过传递的产量参数表示的是旧的属性值
*/
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
4、类型属性
实例属性是特定类型实例的属性。当创建一个类型的实例时，这个实例有自己的属性值的集合，这将它与其它实例区分开来。

也可以定义属于类型本身的属性，即使创建再多的这个类的实例，这个属性也不属于任何一个，它只属于类型本身，这样的属性就称为类型属性。

类型属性适用于定义那些特定类型实例所通用的属性，例如一个可以被所有实例使用的常量属性（就像c中的静态常量），或者变量属性（c中的静态变量）。

可以为值类型（结构、枚举）定义存储类型属性和计算类型属性。对类而言，只能够定义计算类型属性。

值类型的存储类型属性可以是常量也可以是变量。而计算类型属性通常声明成变量属性，类似于计算实例属性

注意
不想存储实例属性，你需要给存储类型属性一个初始值。因为类型本身在初始化时不能为存储类型属性设置值
*/

//类型属性句法
//对值类型而言，定义类型属性使用static关键字，而定义类类型的类型属性使用class关键字。下面的例子展示了存储和计算类型属性的用法：

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
         return 20
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {     // return an Int value here
        return 10
    }
}
class SomeClass {
    class var computedTypeProperty: Int {
        // return an Int value here
        return 30
    }
    
}
//查询与设置类型属性
//像实例属性一样，类型属性通过点操作符来查询与设置。但是类型属性的查询与设置是针对类型而言的，并不是针对类型的实例。例如
print(SomeClass.computedTypeProperty)
// prints "42"
print(SomeStructure.storedTypeProperty)
// prints "Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)

//以下的AudioChannel结构实例来表示：
struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                //cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}
//注意:第一道检查中，didSet为currentLevel设置了新值。这并不会造成观察者再次被调用

//可以创建两个AudioChannel实例，leftChannel和rightChannel，来表示一个立体声系统：
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// prints "7"
print(AudioChannel.maxInputLevelForAllChannels)
// prints "7”

//如果像设置右通道的currentlevel为11，它的值将被截短成为10，而且maxInputLevelForAllChannels的值也将更新为10:
rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
// prints "10"
print(AudioChannel.maxInputLevelForAllChannels)
