//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/



//20 - 扩展
import UIKit

var str = "Hello, playground"

/*
扩展就是向一个已有的类、结构体或枚举类型添加新功能（functionality）。这包括在没有权限获取原始源代码的情况下扩展类型的能力（即逆向建模）。扩展和 Objective-C 中的分类（categories）类似。（不过与Objective-C不同的是，Swift 的扩展没有名字。）

Swift 中的扩展可以：

添加计算型属性和计算静态属性
定义实例方法和类型方法
提供新的构造器
定义下标
定义和使用新的嵌套类型
使一个已有类型符合某个接口

如果:
你定义了一个扩展向一个已有类型添加新功能，那么这个新功能对该类型的所有已有实例中都是可用的，即使它们是在你的这个扩展的前面定义的。
*/

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
1.扩展语法（Extension Syntax）
声明一个扩展使用关键字extension：
extension SomeType {
// 加到SomeType的新功能写到这里
}
*/
//一个扩展可以扩展一个已有类型，使其能够适配一个或多个协议（protocol）。当这种情况发生时，接口的名字应该完全按照类或结构体的名字的方式进行书写：
/*
extension SomeType: SomeProtocol, AnotherProctocol {
// 协议实现写到这里
}
*/

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
2.计算型属性（Computed Properties）
  扩展可以向已有类型添加计算型实例属性和计算型类型属性。
*/
extension Double {
    var km: Double {
        return self * 1_000.0
    }
    var m : Double{
        return self
    }
    var cm: Double {
        return self / 100.0
    }
    var mm: Double{
        return self / 1_000.0
    }
    var ft: Double {
        return self / 3.28084
    }
    static var mh: Double {
        return 20.0
    }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// 打印输出："One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

//扩展可以添加新的计算属性，但是不可以添加存储属性，也不可以向已有属性添加属性观测器(property observers)。

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
3.构造器（Initializers）

扩展可以向已有类型添加新的构造器。这可以让你扩展其它类型，将你自己的定制类型作为构造器参数，或者提供该类型的原始实现中没有包含的额外初始化选项。
*/

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))

//你可以提供一个额外的使用特殊中心点和大小的构造器来扩展Rect结构体：

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
size: Size(width: 3.0, height: 3.0))

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
4.方法（Methods）
扩展可以向已有类型添加新的实例方法和类型方法
*/
extension Int {
    func repetitions(task: () -> ()) {
        for _ in 0...self {
            task()
        }
    }
}

5.repetitions { () -> () in
    print("heh")
}
//可以使用 trailing 闭包使调用更加简洁：
3.repetitions{
print("haod ")
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
5.修改实例方法（Mutating Instance Methods）

通过扩展添加的实例方法也可以修改该实例本身。结构体和枚举类型中修改self或其属性的方法必须将该实例方法标注为mutating，正如来自原始实现的修改方法一样。
*/
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
6.下标（Subscripts）
扩展可以向一个已有类型添加新下标。这个例子向Swift内建类型Int添加了一个整型下标
*/

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0...digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
// returns 5
746381295[1]
// returns 9
746381295[2]
// returns 2
746381295[8]


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
7.嵌套类型（Nested Types）

扩展可以向已有的类、结构体和枚举添加新的嵌套类型：

*/
extension Character {
    enum Kind {
        case Vowel, Consonant, Other
    }
    var kind: Kind {
        switch String(self).lowercaseString {
        case "a", "e", "i", "o", "u":
            return .Vowel
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
        "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            return .Consonant
        default:
            return .Other
        }
    }
}

func printLetterKinds(word: String) {
    print("'\\(word)' is made up of the following kinds of letters:")
    for character in word.characters {
        switch character.kind {
        case .Vowel:
            print("vowel ")
        case .Consonant:
            print("consonant ")
        case .Other:
            print("other ")
        }
    }
    print("\n")
}
printLetterKinds("Hello")

//由于已知character.kind是Character.Kind型，所以Character.Kind中的所有成员值都可以使用switch语句里的形式简写，比如使用 .Vowel代替Character.Kind.Vowel

