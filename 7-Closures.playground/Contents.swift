//: Playground - noun: a place where people can play



/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//7-闭包

import UIKit

var str = "Hello, playground"
//闭包（Closures）是独立的函数代码块，能在代码中传递及使用。Swift中的闭包与C和Objective-C中的代码块及其它编程语言中的匿名函数相似。
//闭包可以在上下文的范围内捕获、存储任何被定义的常量和变量引用。因这些常量和变量的封闭性，而命名为“闭包（Closures）”。Swift能够对所有你所能捕获到的引用进行内存管理。
//全局函数和嵌套函数已在 Functions(函数)中介绍过，实际上这些都是特殊的闭包函数
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
1、闭包表达式
以下以同一个sort函数进行几次改进，每次函数都更加简洁，以此说明闭包表达式的优化。
*/
//Sort函数 Swift的标准函数库提供了一个名为sort的函数，它通过基于输出类型排序的闭包函数，给已知类型的数组数据的值排序。一旦完成排序工作，会返回一个同先前数组相同大小，相同数据类型，并且的新数组，并且这个数组的元素都在正确排好序的位置上。
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//sort函数需要两个参数：
//一个已知值类型的数组
//一个接收两个参数的闭包函数，这两个参数的数据类型都同于数组元素。并且返回一个Bool表明是否第一个参数应排在第二个参数前或后。

func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversed = names.sort(backwards)

//闭包表达式语法 闭合表达式语法具有以下一般构造形式
/*{ (parameters) -> return type in
        statements
}
*/
//下面的例子展示了上面的 backwards 函数对应的闭包表达式构造函数代码
reversed = names.sort({ (s1: String, s2: String) -> Bool in
    return s1 > s2
})
//需要注意的是声明内联闭包的参数和返回值类型与 backwards 函数类型声明相同。 在这两种方式中，都写成了 (s1: String, s2: String) -> Bool类型。 然而在内联闭包表达式中，函数和返回值类型都写在大括号内，而不是大括号外。闭包的函数体部分由关键字 in 引入。 该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始


//根据上下文推断类型  因为排序闭包是作为函数的参数进行传入的，Swift可以推断其参数和返回值的类型。 sort 期望第二个参数是类型为 (String, String) -> Bool 的函数，因此实际上 String, String 和 Bool 类型并不需要作为闭包表达式定义中的一部分。 因为所有的类型都可以被正确推断，返回箭头 (->) 和 围绕在参数周围的括号也可以被省略

reversed = names.sort({ s1, s2 in return s1 > s2 } )
print(reversed)

//单行表达式闭包可以省略 return
//单行表达式闭包可以通过隐藏 return 关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为：
reversed = names.sort({ s1, s2 in s1 > s2 } )

//参数名简写
//Swift 自动为内联函数提供了参数名称简写功能，可以直接通过 $0,$1,$2等名字来引用闭包的参数值。
//如果在闭包表达式中使用参数名称简写，可以在闭包参数列表中省略对其的定义，并且对应参数名称简写的类型会通过函数类型进行推断。 in 关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成：
reversed = names.sort({ $0 > $1 } )

//运算符函数 运算符函数实际上是一个更短的方式构造以上的表达式。
reversed = names.sort(>)


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2、Trailing 闭包
*/
//如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用 trailing 闭包来增强函数的可读性。
//Trailing 闭包是一个书写在函数括号之外(之后)的闭包表达式，函数支持将其作为最后一个参数调用
func someFunctionThatTakesAClosure(closure: () -> ()) {
    // function body goes here
}
// here's how you call this function without using a trailing closure:
someFunctionThatTakesAClosure({
    // closure's body goes here
})
// here's how you call this function with a trailing closure instead:
someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}

someFunctionThatTakesAClosure { () -> () in
    
}

//举例来说，Swift 的 Array 类型有一个 map 方法，其获取一个闭包表达式作为其唯一参数。数组中的每一个元素调用一次该闭包函数，并返回该元素所映射的值(也可以是不同类型的值)。 具体的映射方式和返回值类型由闭包来指定。
let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
//你现在可以通过传递一个 trailing 闭包给 numbers 的 map 方法来创建对应的字符串版本数组。需要注意的时调用 numbers.map不需要在 map 后面包含任何括号，因为只需要传递闭包表达式这一个参数，并且该闭包表达式参数通过 trailing 方式进行撰写
let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}
print(strings)

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
3、获取值
*/
//看下面这个例子，一个函数方法为makeIncrementor、这是一个嵌套函数，在这个函数体内嵌套了另一个函数方法：incrementor，在这个incrementor函数体内有两个参数： runningTotal和amount，实际运作时传进所需的两个参数后，incrementor函数每次被调用时都会返回一个runningTotal值提供给外部的makeIncrementor使用
func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}
let incrementByTen = makeIncrementor(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()
// 如果你创建另一个incrementor，其会有一个属于自己的独立的runningTotal变量的引用。
let incrementBySeven = makeIncrementor(forIncrement: 7)
incrementBySeven() // 并不会影响incrementByTen()调用
incrementByTen()

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
4、引用类型闭包
在上面的例子中，incrementBySeven和incrementByTen是常量，但是这些常量在闭包的状态下依然可以被修改。为何？很简单，因为函数和闭包是引用类型。
当你指定一个函数或一个闭包常量/变量时、实际上是在设置该常量或变量是否为一个引用函数。在上面的例子中，它是闭合的选择，incrementByTen指的是恒定的，而不是封闭件本身的内容。
这也意味着，如果你分配一个封闭两种不同的常量或变量，这两个常量或变量将引用同一个闭包：
*/
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()

