//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//9-类和结构体
import UIKit

var str = "Hello, playground"

//类与结构是编程人员在代码中会经常用到的代码块。在类与结构中可以像定义常量，变量和函数一样，定义相关的属性和方法以此来实现各种功能。

//和其它的编程语言不太相同的是，Swift不需要单独创建接口或者实现文件来使用类或者结构。Swift中的类或者结构可以在单文件中直接定义，一旦定义完成后，就能够被直接其它代码使用。
/*
1、类和结构的异同

类和结构有一些相似的地方，它们都可以：
定义一些可以赋值的属性；
定义具有功能性的方法
定义下标，使用下标语法
定义初始化方法来设置初始状态
在原实现方法上的可扩展性
根据协议提供某一特定类别的基本功能

类还有一些结构不具备的特性：
类的继承性
对类实例实时的类型转换
析构一个类的实例使之释放空间
引用计数，一个类实例可以有多个引用
*/

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
1.定义语法
类和结构拥有相似的定义语法，使用class关键词定义一个类，struct关键词定义结构。每个定义都由一对大括号包含
*/
class SomeClass {
    // class definition goes here
}
struct SomeStructure {
    // structure definition goes here
}
//下面是一个结构和一个类的定义示例：
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
let someResolution = Resolution()
let someVideoMode = VideoMode()
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
//结构类型的成员初始化方法
let anotherResolution = Resolution(width: 200,height: 299)
print("The width of someResolution is \(anotherResolution.width)")


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2、结构和枚举类型是数值类型
在Swift中所有的结构和枚举类型都是数值类型。这意味这你实例化的每个结构和枚举，其包含的所有属性，都会在代码中传递的时候被完整复制
*/
//下面的这个例子可以说明这个特性：
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
//声明了一个常量hd，是Resolution的实例化，宽度是1920，高度是1080，然后声明了一个变量cinema，和hd相同。这个时候表明，cinema和hd是两个实例，虽然他们的宽度都是1920，高度都是1080
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
// prints "cinema is now 2048 pixels wide"
print("hd is still \(hd.width) pixels wide")

enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
3、类是引用类型
和数值类型不同引用类型不会复制整个实例，当它被赋值给另外一个常量或者变量的时候，而是会建立一个和已有的实例相关的引用来表示它
*/
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

//特征操作
//因为类是引用类型，那么就可能存在多个常量或者变量只想同一个类的实例（这对于数值类型的结构和枚举是不成立的）。

//可以通过如下两个操作来判断两个常量或者变量是否引用的是同一个类的实例：

//相同的实例(===)

//不同的实例(!==)
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
}
/*
注意: 相同的实例判断使用三个连续的等号，这和相等（两个等号）是不同的
实例相同表示的是两个变量或者常量所引用的是同一个类的实例
相等是指两个实例在数值上的相等，或者相同。
*/

//指针

//如果你有C，C++或者Objective-C的编程经验，你一定知道在这些语言中使用指针来引用一个内存地址。Swift中引用一个实例的常量或变量跟C中的指针类似，但是不是一个直接指向内存地址的指针，也不需要使用*记号表示你正在定义一个引用。Swift中引用和其它变量，常量的定义方法相同。


