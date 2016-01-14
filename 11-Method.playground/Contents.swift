//: Playground - noun: a place where people can play

/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//11 - 方法
import UIKit

var str = "Hello, playground"

//方法是关联到一个特定类型的函数。类、结构、枚举所有可以定义实例方法,封装特定任务和功能处理给定类型的一个实例。类、结构、枚举类型还可以定义方法,相关的类型本身。类型方法类似于objective – c类方法。


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
1.实例方法
*/
class Counter {
    var count = 0
    func increment() {
        count++
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
// the initial counter value is 0
counter.increment()
// the counter's value is now 1
counter.incrementBy(5)
// the counter's value is now 6
counter.reset()

//本地和外部参数名称的方法
//函数参数可以有一个本地名称(在函数体内使用)和外部名称(在调用函数时使用),所述外部参数名称。方法参数也是如此,因为方法与类型相关的函数。然而,本地名称和外部名称的默认行为是不同的函数和方法
class OtherCounter {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}
let otherCoun = OtherCounter()
otherCoun.incrementBy(2, numberOfTimes: 5)
print(otherCoun.count)

//  修改外部参数名称的行为方法
//有时是有用的提供一个外部方法的第一个参数的参数名称,即使这不是默认行为。你自己可以添加一个显式的外部名称,或者你可以用一个散列前缀的名字的第一个参数标志使用本地名称作为外部的名字。
//相反,如果你不想为第二个提供外部名称或后续参数的方法,覆盖默认行为通过使用下划线字符(_)作为一个明确的外部参数名称参数


//self属性
//一个类型的每个实例都有所谓的一个隐含self属性，它是完全等同于该实例本身。您可以使用这个隐含的self属性来引用当前实例中它自己的实例方法

class ThreeCounter {
    var count = 0
    func increment() {
      self.count++
    }
}

//在实践中，你不需要写self，这在你的代码会非常频繁。如果你没有明确写self，Swift假设你是指当前实例的属性或方法，每当你使用一个方法中一个已知的属性或方法名。
//如果没有self前缀，Swift将假定x的两种用法称为X的方法参数

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    print("This point is to the right of the line where x == 1.0")
}


//修改值类型的实例方法
//结构和枚举值类型。默认情况下,一个值类型的属性不能修改它的实例方法,然而,如果您需要修改的属性结构或枚举在一个特定的方法,你可以选择该方法的变化行为。但任何更改都会使它得编写的方法结束时回到原来的结构。当该方法结束时还可以分配一个完全新的实例对其隐含的self属性,而这个新的实例将取代现有的。
struct SomePoint {
    var x = 0.0, y = 0.0
     mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var otherPoint = SomePoint(x: 1.0, y: 1.0)
otherPoint.moveByX(2.0, y: 3.0)
print("The point is now at (\(otherPoint.x), \(otherPoint.y))")

//请注意,您不能调用变异方法结构类型的常数，因为它的属性不能改变，即使它们是可变的特性，如在固定结构实例存储的属性描述：

//let fiexedPoint = SomePoint(x: 3.0,y: 4.0)
//fiexedPoint.moveByX(2.0, y: 3.0)

// 分配中的self变异方法
struct OtherSomePoint {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = OtherSomePoint(x: x + deltaX, y: y + deltaY)
    }
}
var other = OtherSomePoint(x: 1.0,y: 2.0)
other.moveByX(3.0, y: 5.0)
other.x


//变异的方法枚举可以设置self参数是从同一个枚举不同的成员
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight is now equal to .High
ovenLight.next()



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2.类型方法
如上所述,实例方法的方法要求一个特定类型的实例。您还可以定义该类型自身的方法，这种方法被称为type方法，您显示的type方法直接在类结构体里面用class func开头 ，对于枚举和结构来说，类型方法是用static func开头
*/
class SomeClass {
//    static var count = 0
    class func someTypeMethod() {
        // type method implementation goes here
        print("类型方法调用")
//        ++self.count
    }
}
SomeClass.someTypeMethod()
//在类型方法的主体，隐含的self属性是指类型本身，而不是该类型的一个实例。对于结构体和枚举，这意味着你可以使用自助静态属性和静态方法的参数消除歧义，就像你做的实例属性和实例方法的参数
struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
      var currentLevel = 1
      mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.completedLevel(1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advanceToLevel(6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
