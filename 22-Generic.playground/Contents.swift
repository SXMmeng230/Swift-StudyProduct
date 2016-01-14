//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/

//22 - 泛型
import UIKit

var str = "Hello, playground"

//泛型代码可以让你写出根据自我需求定义、适用于任何类型的，灵活且可重用的函数和类型。它的可以让你避免重复的代码，用一种清晰和抽象的方式来表达代码的意图。
/*
1.泛型所解决的问题

这里是一个标准的，非泛型函数swapTwoInts,用来交换两个Int值：
*/
func swapTwoInts(inout a: Int, inout b: Int){
     let temporaryA = a
     a = b
     b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, b: &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

//swapTwoInts函数是非常有用的，但是它只能交换Int值，如果你想要交换两个String或者Double，就不得不写更多的函数，如 swapTwoStrings和swapTwoDoublesfunctions，如同如下所示：

func swapTwoStrings(inout a: String, inout b: String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(inout a: Double, inout b: Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}
//你可能注意到 swapTwoInts、 swapTwoStrings和swapTwoDoubles函数功能都是相同的，唯一不同之处就在于传入的变量类型不同，分别是Int、String和Double。

//但实际应用中通常需要一个用处更强大并且尽可能的考虑到更多的灵活性单个函数，可以用来交换两个任何类型值

//泛型函数

//泛型函数可以工作于任何类型
func swapTwoValues<T>(inout a: T, inout b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
/*
这个函数的泛型版本使用了占位类型名字（通常此情况下用字母T来表示）来代替实际类型名（如In、String或Doubl）。占位类型名没有提示T必须是什么类型，但是它提示了a和b必须是同一类型T，而不管T表示什么类型。只有swapTwoValues函数在每次调用时所传入的实际类型才能决定T所代表的类型。

另外一个不同之处在于这个泛型函数名后面跟着的展位类型名字（T）是用尖括号括起来的（）。这个尖括号告诉 Swift 那个T是swapTwoValues函数所定义的一个类型。因为T是一个占位命名类型，Swift 不会去查找命名为T的实际类型。

swapTwoValues函数除了要求传入的两个任何类型值是同一类型外，也可以作为swapTwoInts函数被调用。每次swapTwoValues被调用，T所代表的类型值都会传给函数
*/
swapTwoValues(&someInt, b: &anotherInt)
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, b: &anotherString)

/*
类型参数

在上面的swapTwoValues例子中，占位类型T是一种类型参数的示例。类型参数指定并命名为一个占位类型，并且紧随在函数名后面，使用一对尖括号括起来（如）。

一旦一个类型参数被指定，那么其可以被使用来定义一个函数的参数类型（如swapTwoValues函数中的参数a和b），或作为一个函数返回类型，或用作函数主体中的注释类型。在这种情况下，被类型参数所代表的占位类型不管函数任何时候被调用，都会被实际类型所替换（在上面swapTwoValues例子中，当函数第一次被调用时，T被Int替换，第二次调用时，被String替换。）。

你可支持多个类型参数，命名在尖括号中，用逗号分开。

命名类型参数

在简单的情况下，泛型函数或泛型类型需要指定一个占位类型（如上面的swapTwoValues泛型函数，或一个存储单一类型的泛型集，如数组），通常用一单个字母T来命名类型参数。不过，你可以使用任何有效的标识符来作为类型参数名。
*/

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
2.泛型类型

*/
struct IntStack {
    var items = [Int]()
     mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//这里是一个相同代码的泛型版本：

struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}
//注意到Stack的泛型版本基本上和非泛型版本相同，但是泛型版本的占位类型参数为T代替了实际Int类型。这种类型参数包含在一对尖括号里（<T>），紧随在结构体名字后面。
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

let fromTheTop = stackOfStrings.pop()

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
3.类型约束

swapTwoValues函数和Stack类型可以作用于任何类型，不过，有的时候对使用在泛型函数和泛型类型上的类型强制约束为某种特定类型是非常有用的。类型约束指定了一个必须继承自指定类的类型参数，或者遵循一个特定的协议或协议构成。
*/
//类型约束语法

/*
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
}
上面这个假定函数有两个类型参数。第一个类型参数T，有一个需要T必须是SomeClass子类的类型约束；第二个类型参数U，有一个需要U必须遵循SomeProtocol协议的类型约束。

*/
func findStringIndex(array: [String], valueToFind: String) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, valueToFind: "llama") {
    print("The index of llama is \(foundIndex)")
}

// 泛型版本 但是下面的会有编译错误
//func findIndex<T>(array: [T], _ valueToFind: T) -> Int? {
//    for (index, value) in array.enumerate() {
//        // 并不是所有的类型都支持 == 比较，只有实现Equatable协议的才可以。 所以编译错误
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}

func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let doubleIndex = findIndex([3.14159, 0.1, 0.25], 0.1)
let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
4.关联类型
当定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分是非常有用的。一个关联类型给定作用于协议部分的类型一个节点名（或别名）。作用于关联类型上实际类型是不需要指定的，直到该协议接受。关联类型被指定为typealias关键字。
*/
protocol Container {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}
//非泛型
struct IntRedStack: Container {
    // original IntStack implementation
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

//生成遵循Container协议的泛型Stack类型
struct StackT<T>: Container {
    // original Stack<T> implementation
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(item: T) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}
//扩展一个存在的类型为一指定关联类型

extension Array: Container {}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
5.Where 语句
对于关联类型的定义需求也是非常有用的。你可以通过这样去定义where语句作为一个类型参数队列的一部分。一个where语句使你能够要求一个关联类型遵循一个特定的协议，以及（或）那个特定的类型参数和关联类型可以是相同的。你可写一个where语句，通过紧随放置where关键字在类型参数队列后面，其后跟着一个或者多个针对关联类型的约束，以及（或）一个或多个类型和关联类型的等于关系。
*/
func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, anotherContainer: C2) -> Bool {
        
        // check that both containers contain the same number of items
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // check each pair of items to see if they are equivalent
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // all items match, so return true
        return true
        
}
var stackOtherOfStrings = StackT<String>()
stackOtherOfStrings.push("uno")
stackOtherOfStrings.push("dos")
stackOtherOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

allItemsMatch(stackOtherOfStrings, anotherContainer: arrayOfStrings)
if allItemsMatch(stackOtherOfStrings, anotherContainer: arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
