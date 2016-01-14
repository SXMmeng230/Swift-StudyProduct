//: Playground - noun: a place where people can play




/*
  初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
  github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/




import UIKit

var str = "Hello, playground"

//基础数据类型
//Swift也提供了与C和Objective-C类似的基础数据类型，包括整形Int、浮点数Double和Float、布尔类型Bool以及字符串类型String。Swift还提供了两种更强大的基本集合数据类型，Array和Dictionary，更详细的内容可以参考：Collection Types。

//跟C语言一样，Swift使用特定的名称来定义和使用变量。同样，Swift中也可以定义常量，与C语言不同的是，Swift中的常量更加强大，在编程时使用常量能够让代码看起来更加安全和简洁。
//+++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
1.常量和变量
1.1
在swift中,使用let关键词来声明常量,用var关键词来声明变量
*/
let numberConst = 10
var numberVar = 20
//注意:声明let常量的值不能修改,例如,下面就会报错;var 可以随意修改
//numberConst = 30
numberVar = 50
//1.2 同时,可以一行声明多个变量或常量.例如:
var x = 1,y = 2,z = 3
//1.3 声明常量或变量的类型,例如:声明一个String类型的numberVarType的常量 用分号:表示
var numberVarType:String
//1.4 常量或变量的命名 Swift中可以使用几乎任何字符来作为常量和变量名，包括Unicode，比如：
let $ = 13
let 你好 = "你好"
let 😊 = "笑"
//注意:名称中不能含有数学符号，箭头，无效的Unicode，横线-和制表符，且不能以数字开头，尽管数字可以包含在名称里。一旦完成了声明，就不能再次声明相同名称的变量或常量，或者改变它的类型。变量和常量也不能互换。
//1.5 输出常量或变量
print(numberVar)
print("这个是一个常量数字\(numberConst)")

 //+++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2.分号
和其它一些编程语言不同，Swift不需要使用分号 ; 来分隔每一个语句。当然你也可以选择使用分号，或者你想在一行中书写多个语句。
*/
let dog = "狗";
let cat = "猫"
//注意:如果一行写多个不同的代码,必须用分号隔开,如果不用分号,将会报错,例如
//print(dog) print(cat) 报错
print(dog);print(cat) //用分号,正确

//+++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
3.类型安全和类型推导
Swift是一种类型安全的语言。类型安全就是说在编程的时候需要弄清楚变量的类型。如果您的代码部分需要一个字符串，你不能错误地传递一个整数类型。

因为Swift是类型安全的，它会在编译的时候就检查你的代码，任何类型不匹配时都会报错。这使得编程人员能够尽快捕获并尽可能早地在开发过程中修正错误。
当你声明一个常量或变量并给出初始值类型的时候，类型推导就显得特别有用。这通常是通过给所声明的常量或变量赋常值来完成的
例如:如果您指定42到一个新的常数变量，而不用说它是什么类型，Swift推断出你想要的常量是一个整数，因为你已经初始化它为一个整数
*/
let meaningOfLift = 42
let pi = 3.1415926
//+++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
4.数值转换
数值类型之间的转化必须显式声明
*/
let two = 2
let point = 0.5
let addInt = two + Int(point)
let addDouble = Double(two) + point
//如果不转换,编译器将报错,swift不允许不同类型之间的操作

//+++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
5.类型别名 
类型别名为现有类型定义的可替代名称。你可以使用typealias关键字定义类型别名。类型别名可以帮助你使用更符合上下文语境的名字来指代一个已存在的类型
*/
typealias sample = UInt16
var maxSaple = sample.max //等同于 var maxSaple = UInt16.max
print(maxSaple)

//+++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
6.BOOL类型
Swift中的布尔类型使用Bool定义，也被称为Logical（逻辑）类型，可选值是true和false 类似于OC中的,YES or NO
*/
let isGood = true
let isBad = false

//+++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
7.元组类型
元组类型可以将一些不同的数据类型组装成一个元素，这些数据类型可以是任意类型，并且不需要是同样的类型。
*/
let http404Error = (404,"Not Found") //声明一个元组,是有一个int和String类型组成的,同时你还可以随意指定元组中的类型,而元组中的数量也是不限的
//7.1 访问元组数值
let (status,statusMessage) = http404Error
print("The status is \(status),message is \(statusMessage)")
//如果仅需要元组中的个别值，可以使用(_)来忽略不需要的值
let (just_status,_) = http404Error
print("The Just Status is \(just_status)")
//另外，也可以使用元素序号来选择元组中的值，注意序号是从0开始的
print("The index status is \(http404Error.0) ,message is \(http404Error.1)")
//在创建一个元组的时候，也可以直接指定每个元素的名称，然后直接使用元组名.元素名访问，如
let http202Succ = (status:202,message:"Success")
print("The success status is \(http202Succ.status),message is \(http202Succ.message)")

//+++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
8.可选类型
在一个值可能不存在的时候，可以使用可选类型。这种类型的定义是：要么存在这个值，且等于x，要么在这个值 不存在。
下面给出一个例子，在Swift中 能够将一个字符串转换为一个Int类型。但是需要注意的是，不是所有的字符串都可以转换为整数。比如字符串”123″可以转换为123，但是”hello, world”就不能被转换,不能转换就会返回nil
*/
let possibleNumber = "123"
let converNumbe = Int(possibleNumber)

//+++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
9.if语句和强制解包
可以使用if语句来检测一个可选类型是否包含一个特定的值，如果一个可选类型确实包含一个值，在if语句中它将返回true，否则返回false。如果你已经检测确认该值存在，那么可以使用或者输出它，在输出的时候只需要在名称后面加上感叹号(!)即可，意思是告诉编译器：我已经检测好这个值了，可以使用它了
*/
if (converNumbe != nil) {
print(" 这个一个强解包 \(converNumbe!)")
}else {
 print("不能解包成Int类型")
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
10.选择绑定
   选择绑定帮助确定一个可选值是不是包含了一个值，如果包含，把该值转化成一个临时常量或者变量
例如:上面的例子可以改成如下
*/
if let contverSuccNumber = Int(possibleNumber){
  print("修改强解析成功 ,其值为:\(contverSuccNumber)")
}else {
  print("修改失败")
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
11.nil
如果你定义了一个可选类型并且没有给予初始值的时候，会默认设置为nil

注: Swift 的nil不同于Object-C中的nil. Object-C中，nil是一个指针指向不存在的对象。Swift中，nil不是指针而是一个特定类型的空值。任何类型的可选变量都可以被设为nil，不光是指针

*/

//+++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
12.隐式解包可选类型
在上面的例子中，可选类型表示一个常量/变量可以没有值。可选类型可以被if语句检测是否有值，并且可以被可选绑定解包。

但是在一些情况下，可选类型是一直有效的，那么可以通过定义来隐式地去掉类型检查，强制使用可选类型。这些可选类型被成为隐式解包的可选类型。你可以直接在类型后面加! 而不是？来指定。
*/
let possibleString: String? = "An optional string."
print(possibleString!)
let assumedString: String! = "An implicitly unwrapped optional string."
print(assumedString)
//注：如果一个可选类型存在没有值的可能的话，不应该使用解包可选类型。这种情况下，一定要使用正常的可选类型。

//+++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
13.断言
断言是一种实时检测条件是否为true的方法，也就是说，断言假定条件为true。断言保证了后续代码的执行依赖于条件的成立。如果条件满足，那么代码继续执行，如果这个条件为false，那么代码将会中断执行。

在Xcode中，在调试的时候如果中断，可以通过查看调试语句来查看断言失败时的程序状态。断言也能提供适合的debug信息。 使用全局函数assert来使用断言调试，assert函数接受一个布尔表达式和一个断言失败时显示的消息，如：
*/
let age = 3
assert(age >= 0, "A person's age cannot be less than zero")
/*
使用断言的时机

当需要检测一个条件可能是false，但是代码运行必须返回true的时候使用。下面给出了一些常用场景，可能会用到断言检测：

传递一个整数类型下标的时候，比如作为数组的Index，这个值可能太小或者太大，从而造成数组越界；
传递给函数的参数，但是一个无效的参数将不能在该函数中执行
一个可选类型现在是nil，但是在接下来的代码中，需要是非nil的值才能够继续运行。
*/
