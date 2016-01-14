//: Playground - noun: a place where people can play



/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//6-函数
import UIKit

var str = "Hello, playground"
//函数是执行特定任务的代码自包含块。给定一个函数名称标识, 当执行其任务时就可以用这个标识来进行”调用”。

//Swift的统一的功能语法足够灵活来表达任何东西，无论是甚至没有参数名称的简单的C风格的函数表达式，还是需要为每个本地参数和外部参数设置复杂名称的Objective-C语言风格的函数。参数提供默认值，以简化函数调用，并通过设置在输入输出参数，在函数执行完成时修改传递的变量

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
1、函数的声明与调用
*/
func sayHello(personName: String) -> String {
    let greeting = "Hello, " + personName + "!"
    return greeting
}
//注意:所有这些信息都汇总到函数的定义中，并以func关键字为前缀。您指定的函数的返回类型是以箭头->（一个连字符后跟一个右尖括号）以及随后类型的名称作为返回的
sayHello("Sun")//函数调用
//其实前面这个可以直接return就可以了 
func sayHelloName(name:String) ->String{
return "\(name)"
}
sayHelloName("wang")


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2、函数的参数和返回值
*/
//在swift中函数的参数和返回值是非常具有灵活性的。你可以定义任何东西无论是一个简单的仅仅有一个未命名的参数的函数还是那种具有丰富的参数名称和不同的参数选项的复杂函数
//多参数
func lengthAll(start:Int,end:Int) ->Int{
return start - end
}
lengthAll(9, end: 3)

//无参数函数
//函数并没有要求一定要定义的输入参数。下面就一个没有输入参数的函数，任何时候调用时它总是返回相同的字符串消息：
func sayHelloWorld() ->String{
return "HelloWorld"
}
sayHelloWorld()

//没有返回值的函数
func sayGoodbye(personName: String) {
    print("Goodbye, \(personName)!")
}
sayGoodbye("Dave")
//严格地说，sayGoodbye功能确实还返回一个值，即使没有返回值定义。函数没有定义返回类型但返回了一个void返回类型的特殊值。它是一个简直是空的元组，实际上零个元素的元组，可以写为（）

//既没有参数,也没有返回值
func sayHelloAndGoodbye(){
    print("sayHelloAndGoodbye")
}
sayHelloAndGoodbye()

//多返回值函数
//你可以使用一个元组类型作为函数的返回类型返回一个有多个值组成的一个复合作为返回值
func count(string: String) -> (vowels: Int, consonants: Int, others: Int) {
    var vowels = 0, consonants = 0, others = 0
    for character in string.characters {
        switch String(character).lowercaseString {
        case "a", "e", "i", "o", "u":
            ++vowels
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
        "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            ++consonants
        default:
            ++others
        }
    }
    return (vowels, consonants, others)
}
let total = count("some arbitrary string!")
print("\(total.vowels) vowels and \(total.consonants) consonants")

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
3、函数参数名

所有上面的函数都为参数定义了参数名称：然而，这些参数名的仅能在函数本身的主体内使用，在调用函数时，不能使用。这些类型的参数名称被称为本地的参数，因为它们只适用于函数体中使用。
*/
//外部参数名 有时当你调用一个函数将每个参数进行命名是非常有用的，以表明你传递给函数的每个参数的目的。如果你希望用户函数调用你的函数时提供参数名称,除了设置本地地的参数名称，也要为每个参数定义外部参数名称。你写一个外部参数名称在它所支持的本地参数名称之前,之间用一个空格来分隔:

func addFunction(exceName name:String){
    print(name)
}
addFunction(exceName: "Sun")

//用_来省略外部参数名
func firstFunction(name:String,_ className:String){
print("\(name)是\(className)的学生")
}
firstFunction("wang", "一班")

//参数的默认值可以为任何参数设定默认值来作为函数的定义的一部分。如果默认值已经定义，调用函数时就可以省略该参数的传值
func someAddFunction(name:String = "sun"){
print(name)
}
someAddFunction("wang")

//可变参数
//一个可变参数的参数接受零个或多个指定类型的值。当函数被调用时，您可以使用一个可变参数的参数来指定该参数可以传递不同数量的输入值。写可变参数的参数时，需要参数的类型名称后加上点字符（…）。
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
arithmeticMean(3, 8, 19)

//常量参数和变量参数
//函数参数的默认值都是常量。试图改变一个函数参数的值会让这个函数体内部产生一个编译时错误。这意味着您不能错误地改变参数的值
//但是，有时函数有一个参数的值的变量副本是非常有用的。您可以通过指定一个或多个参数作为变量参数，而不是避免在函数内部为自己定义一个新的变量。变量参数可以是变量而不是常量,并给函数中新修改的参数的值的提供一个副本。
func alignRight(var string: String, count: Int, pad: Character) -> String {
    let amountToPad = count - string.characters.count
    for _ in 1...amountToPad {
        string = String(pad) + string
    }
    return string
}
let originalString = "hello"
let paddedString = alignRight(originalString, count: 10, pad: "-")

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
4、函数类型
每个函数都有一个特定的类型，包括参数类型和返回值类型，比如：

*/
func addTwoInts(a: Int, b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(a: Int, b: Int) -> Int {
    return a * b
}
//这个例子定义了两个简单的数学函数addTwoInts和multiplyTwoInts。每个函数接受两个int参数，返回一个int值，执行相应的数学运算然后返回结果 这两个函数的类型是(Int, Int)->Int可以解释为：这个函数类型它有两个int型的参数，并返回一个int类型的值

//使用函数类型 在swift中你可以像任何其他类型一样的使用函数类型。例如，你可以定义一个常量或变量为一个函数类型，并指定适当的函数给该变量
var mathFunc:(Int,Int) ->Int = addTwoInts
mathFunc(2,5)

//函数类型的参数
//可以使用一个函数类型，如(Int, Int)->Int作为另一个函数的参数类型。这使你预留了一个函数的某些方面的实现，让调用者调用函数时提供
func printMathResult(mathFunction: (Int, Int) -> Int, a: Int, b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, a: 3, b: 5)

//函数类型的返回值
//可以使用一个函数类型作为另一个函数的返回类型。返回的函数(->)即你的返回箭头后，立即写一个完整的函数类型就做到这一点。
//下面的例子定义了两个简单的函数，分别是stepForward和stepBackward。stepForward函数返回输入值自增1，而stepBackward函数返回输入值自减1。这两个函数都有一个相同的类型 (Int) -> Int：
func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}
//这里有一个chooseStepFunction函数，它的返回类型是”函数类型(Int) -> Int”。chooseStepFunction返回一个基于布尔参数的stepBackward或stepForward函数类型:
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}

let stepWard = chooseStepFunction(false)
stepWard(10)


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
5、嵌套函数

迄今为止所有你在本章中遇到函数都是全局函数，在全局范围内定义。其实你还可以在其他函数中定义函数，被称为嵌套函数。

嵌套函数默认对外界是隐藏的，但仍然可以调用和使用其内部的函数。内部函数也可以返回一个嵌套函数，允许在嵌套函数内的另一个范围内使用。
*/

func chooseFunction(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseFunction(currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
