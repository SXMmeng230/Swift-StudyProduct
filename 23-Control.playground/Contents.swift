//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/

//23 - 访问控制
import UIKit

var str = "Hello, playground"

//访问控制可以限定其他源文件或模块中代码对你代码的访问级别。这个特性可以让我们隐藏功能实现的一些细节，并且能够指定哪些代码能够被访问和使用。
//Swift代码如果不明确写出访问级别，默认是同一个模块内可访问。
/*

Access Levels 访问控制
Swift提供三种访问控制：

Public 所有的地方都能访问到
Internal 模块内能访问
Private 只能在定义它的源文件中访问

在Swift中如果没有明确访问级别，将会被设置成默认的访问级别，internal

在Framework中，只有明确的标明public的接口，才能被其他模块访问

Access Levels for Unit Test Targets -> Unit Test Target的访问级别
默认情况下，Test Target只能访问使用public标明的实体。但是如果我们可以在import的时候，添加@testable，使测试类能够访问到模块中internal声明的实体
*/
public class SomePublicClass {          // explicitly public class
    public var somePublicProperty = 0    // explicitly public class member
    var someInternalProperty = 0         // implicitly internal class member
    private func somePrivateMethod() {}  // explicitly private class member
}

class SomeInternalClass {               // implicitly internal class
    var someInternalProperty = 0         // implicitly internal class member
    private func somePrivateMethod() {}  // explicitly private class member
}

private class SomePrivateClass {        // explicitly private class
    var somePrivateProperty = 0          // implicitly private class member
    func somePrivateMethod() {}          // implicitly private class member
}

/*
Function Types 函数
受参数类型、返回类型访问级别的影响。选择函数声明访问级别、参数类型访问级别、返回类型访问级别最低的作为函数的访问级别。如果最后确定函数的访问级别是private，需要明确声明，不会自动计算出来，
*/

class AB {
    private class B {}
    private func test(a:B) { // 必须明确声明为private
        print("x")
    }
}

/*
Enumeration Types 枚举类型
枚举类型的case的访问级别与枚举类型的访问级别相同。
枚举的原始值和关联值的访问级别必须要高于枚举的访问级别。
*/
public enum CompassPoint {
    case North
    case South
    case East
    case West
}

/*
Nested Types 嵌套类型
如果在private级别的类型中定义嵌套类型，那么该嵌套类型就自动拥有private访问级别。如果在public或者internal级别的类型中定义嵌套类型，那么该嵌套类型自动拥有internal访问级别。如果想让嵌套类型拥有public访问级别，那么需要明确地申明该嵌套类型的访问级别
*/


/*
Subclassing 子类
子类的访问级别不能高于父类。子类能够重写父类能够被子类访问的方法。同时子类还能够通过重写父类private的方法。通过重写能够修改父类private方法在子类中的访问级别，如下
*/

public class A {
    private func someMethod() {
        print("AAAAAA")
    }
}

internal class B: A {
    override internal func someMethod() {
        super.someMethod()
        print("BBBBBBB")
    }
}

let bbb = B()
bbb.someMethod()

/*
Constants, Variables, Properties, and Subscripts 常量、变量、属性、下标
声明的常量、变量、属性、下标的访问级别，不能高于其类型的访问级别。
*/


/*
Getters and Setters Getter和Setter
常量、变量、属性、下标索引的Getters和Setters的访问级别继承自它们所属成员的访问级别。
通过private(set)或internal(set)先为它们的写权限申明一个较低的访问级别
*/

struct TrackedString {
    private(set) var numberOfEdits = 0 // 只能在源文件中设置 在模块中只读
    var value: String = "" {
        didSet {
            numberOfEdits++
        }
    }
}

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")

public struct AnotherTrackedString {
    public private(set) var numberOfEdits = 0 // getter public setter是private
    public var value: String = "" {
        didSet {
            numberOfEdits++
        }
    }
    public init() {}
}


/*
Initializers 构造器
自定义构造器可以指定一个比类型访问级别低的访问级别。但是指定构造器必须和类型的访问级别相同。构造器的参数类型的访问级别不能比构造器的低。

Default Initializers 默认构造器
类型非public的时候，默认构造器与类型的访问级别一致。如果是类型是public，默认构造器是internal。如果想使其是public的可以提供一个无参的public的构造器

Default Memberwise Initializers for Structure Types 结构体的默认成员初始化方法
如果结构体中的任一存储属性的访问级别为private，那么它的默认成员初始化方法访问级别就是private。否则，结构体的初始化方法的访问级别依然是internal。 如果你想在其他模块中使用该结构体的默认成员初始化方法，那么你需要提供一个访问级别为public的默认成员初始化方法。

*/
