//: Playground - noun: a place where people can play

/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//16 - 自动引用计数
import UIKit

var str = "Hello, playground"

//Swift使用自动引用计数（ARC）来管理应用程序的内存使用。这表示内存管理已经是Swift的一部分，在大多数情况下，你并不需要考虑内存的管理。当实例并不再被需要时，ARC会自动释放这些实例所使用的内存。

//注意 : 引用计数仅仅作用于类实例上。结构和枚举是值类型，而非引用类型，所以不能被引用存储和传递。
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
//下面的代码定义了是三个Person？类型的变量，随后的代码中，这些变量用来设置一个Person实例的多重引用。因为这些变量是可选类型（Person？），它们自动被初始化为nil，并且不应用任何Person实例。
var reference1: Person?
var reference2: Person?
var reference3: Person?
reference1 = Person(name: "John Appleseed")
//因为新的Person实例被赋值给变量reference1，因此这是一个强引用。由于有一个强引用的存在，ARC保证了Person实例在内存中不被释放掉。
//如果你将这个Person实例赋值给更多的变量，就建立了相应数量的强引用：
reference2 = reference1
reference3 = reference1
//如果你将nil赋值给其中两个变量从而切断了这两个强引用（包含原始引用），还有一个强引用是存在的，因此Person实例不被释放。
reference1 = nil
reference2 = nil

//直到第三个强引用被破坏之后，ARC才释放这个Person实例，因此之后你就不能在使用这个实例了：
reference3 = nil

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
3、类实例间的强引用循环

在上面的例子中，ARC跟踪指向Person实例的引用并保证只在Person实例不再被使用后才释放。
但是，写出一个类的实例没有强引用指向它这样的代码是可能的。试想，如果两个类实例都有一个强引用指向对方，这样的情况就是强引用循环。
通过在类之间定义弱的（weak）或无主的（unowned）引用可以解决强引用循环这个问题。
*/

class OtherPerson {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let number: Int
    init(number: Int) {
        self.number = number
    }
    var tenant: OtherPerson?
    deinit {
        print("Apartment #\(number) is being deinitialized")
    }
}

var john: OtherPerson?
var number73: Apartment?
john = OtherPerson(name: "Sun")
number73 = Apartment(number: 73)
john!.apartment = number73
number73!.tenant = john
//不幸的是，这样做造成了两个实例间的强引用循环。因此，当你破坏john和number73变量间的强引用、时，引用计数并没有减少到0，ARC也不会释放实例：

john = nil
number73 = nil
//当你将两个变量设置为nil时，各自的析构方法都不会被调用到。强引用循环防止了Person和Apartment实例被释放造成的内存泄漏。


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
4、解决类实例之间的强引用循环
Swift提供了两种方法解决类实例属性间的强引用循环：弱引用和无主（unowned）引用。
*/

//弱引用

//弱引用并不保持对所指对象的强烈持有，因此并不阻止ARC对引用实例的回收。这个特性保证了引用不成为强引用循环的一部分。指明引用为弱引用是在生命属性或变量时在其前面加上关键字weak。
//注意:弱引用必须声明为变量，指明它们的值在运行期可以改变。弱引用不能被声明为常量。

class TwoPerson {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: TwoApartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}
class TwoApartment {
    let number: Int
    init(number: Int) { self.number = number }
    weak var tenant: TwoPerson?
    deinit {
        print("Apartment #\(number) is being deinitialized")
    }
}

//无主引用

//和弱引用一样，无主引用也并不持有实例的强引用。但和弱引用不同的是，无主引用通常都有一个值。因此，无主引用并不定义成可选类型。指明为无主引用是在属性或变量声明的时候在之前加上关键字unowned。
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
class CreditCard {
    let number: Int
    unowned let customer: Customer
    init(number: Int, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
5、闭包的强引用循环

前面你知道了当两个类实例持有对方的强引用时强引用循环是怎样被创建的。你也知道了怎样使用弱引用和无主引用来破坏强引用循环。
当将一个闭包赋值给一个类实例的属性，并且闭包体捕获这个实例时，也可能存在一个强引用循环。捕获实例是因为闭包体访问了实例的属性，就像self.someProperty，或者调用了实例的方法，就像self.someMethod（）。不管哪种情况，这都造成闭包捕获self，造成强引用循环。

*/

class HTMLElement {
    let name: String
    let text: String?
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)"
        } else {
            return "<\(self.name) />"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
//如果设置paragraph变量值为nil，破坏了到HTMLElement实例的强引用，实例和其闭包都不会被析构，因为强引用循环：
paragraph = nil

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
6、解决闭包的强引用循环

通过定义捕获列表为闭包的一部分可以解决闭包和类实例之间的强引用循环。捕获列表定义了在闭包体内何时捕获一个或多个引用类型的规则。像解决两个类实例之间的强引用循环一样，你声明每个捕获引用为弱引用或者无主引用。究竟选择哪种定义取决于代码中其他部分间的关系
定义捕获列表
捕获列表中的每个元素由一对weak／unowned关键字和类实例（self或someInstance）的引用所组成。这些对由方括号括起来并由都好分隔
*/
//将捕获列表放在闭包参数列表和返回类型（如果提供）的前面：
/*
lazy var someClosure: (Int, String) -> String = {
[unowned self] (index: Int, stringToProcess: String) -> String in
// closure body goes here
}
*/

/*
如果闭包没有包含参数列表和返回值，它们可以从上下文中推断出来的话，将捕获列表放在闭包的前面，后面跟着关键字in：
lazy var someClosure: () -> String = {
[unowned self] in
// closure body goes here
}

*/
