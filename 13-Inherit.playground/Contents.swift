//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//13 - 继承
import UIKit

var str = "Hello, playground"

/*
一个类可以从另外一个类中继承方法，属性或者其它的一些特性。当一个类继承于另外一个类时，这个继承的类叫子类，被继承的类叫父类。继承是Swift中类区别于其它类型的一个基本特征。

Swift中的类可以调用父类的方法，使用父类的属性和下标，还可以根据需要使用重写方法或者属性来重新定义和修改他们的一些特性。Swift可以帮助你检查重写的方法和父类的方法定义是相符的。

类还可以为它继承的属性添加观察者，这样可以能够让它在一个属性变化的时候得到通知。属性观察者可以被添加给任何属性，不管它之前是存储属性还是计算属性。
*/

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
1.定义一个基类

任何一个不继承于其它类的类被称作基类
注意：Swift的类不是从一个全局基类继承而来。在你编写代码的时，只要是在类的定义中没有继承自父类的类都是基类。
*/
class Vehicle {
    var numberOfWheels: Int
    var maxPassengers: Int
    func description() -> String {
        return "\(numberOfWheels) wheels; up to \(maxPassengers) passengers"
    }
    init() {
        numberOfWheels = 0
        maxPassengers = 1
    }
}
//通过构造函数可以创建一个类型的实例。尽管构造函数不是方法，但是它们在编码的时候使用了非常相似的语法。构造函数通过确保所有实例的属性都是有效的来创建一个新的实例

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2、产生子类
为了表明一个类是继承自一个父类，需要将父类的名称写在子类的后面，并且用冒号分隔：
*/
class SomeClass: Vehicle {
    // class definition goes here
}
//定义一个新的类叫Bicycle，它继承了Vehicle的特性：
class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description())")

//子类本身也可以作为父类被再次继承：
class Tandem: Bicycle {
    override init() {
        super.init()
        maxPassengers = 2
    }
}
let tandem = Tandem()
print(tandem.description())

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
3、重写
子类可以提供由父类继承来的实例方法，类方法，实例属性或者下标的个性化实现。这个特性被称为重写。
override关键词还能够让Swift编译器检查该类的父类是否有相符的方法，以确保你的重写是可用的，正确的。
*/
//重写方法
class Car: Vehicle {
    var speed: Double = 0.0
   override init() {
        super.init()
        maxPassengers = 5
        numberOfWheels = 4
    }
    override func description() -> String {
        return super.description() + "; "
            + "traveling at \(speed) mph"
    }
}
//重写属性
class SpeedLimitedCar: Car {
    override var speed: Double  {
        get {
            return super.speed
        }
        set {
            super.speed = min(newValue, 40.0)
        }
    }
}
//重写属性观察者
//注意：不能为继承的常量存储属性或者是只读计算属性添加观察者。这些属性值是不能被修改的，因此不适合在重写实现时添加willSet或者didSet方法。
class AutomaticCar: Car {
    var gear = 1
    override var speed: Double {
        didSet {
            gear = Int(speed / 10.0) + 1
        }
    }
    override func description() -> String {
        return super.description() + " in gear \(gear)"
    }
}
let automatic = AutomaticCar()
automatic.speed = 60.0
print("AutomaticCar: \(automatic.description())")

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
4、禁止重写
你可以通过标记final关键词来禁止重写一个类的方法，属性或者下标。在定义的关键词前面标注@final属性即可。

在子类中任何尝试重写父类的final方法，属性或者下标的行为都会在编译时报错。同样在扩展中为类添加的方法，属性或者下标也可以被标记为final。

还可以在类关键词class前使用@final标记一整个类为final(@final class)。任何子类尝试继承这个父类时都会在编译时报错
*/
