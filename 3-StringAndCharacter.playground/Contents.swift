//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//3- 字符串和字符


import UIKit

var str = "Hello, playground"

/*
一个字符串String就是一个字符序列，像”hello,world”,”albatross”这样的。Swift中的字符串是用String关键词来定义的，同时它也是一些字符的集合，用Character定义。

Swift的String和Character类型为代码提供了一个快速的，兼容Unicode的字符解决方案。String类型的初始化和使用都是可读的，并且和C中的strings类似。同时String也可以通过使用+运算符来组合，使用字符串就像使用Swift中的其他基本类型一样简单。
*/


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
1.字符串常量
在代码中可以使用由String预先定义的字符串常量，定义方式非常简单：

let someString = “Some string literal value”

字符串常量可以包括下面这些特殊字符：

空字符\0，反斜杠\，制表符\t，换行符\n，回车符\r，双引号\”和单引号\’

单字节Unicode字符，\xnn，其中nn是两个十六进制数

双字节Unicode字符，\unnnn，其中nnnn是四个十六进制数

四字节Unicode字符，\Unnnnnnnn，其中nnnnnnnn是八个十六进制数

*/
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{1F496}"

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2.初始化一个空串
*/
var emptyStr = "" //方法一
var anotherEmptyStr = String() //方法2
//通过isEmpty属性可以检查一个字符串是否为空

let isEmp = emptyStr.isEmpty

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
3.变长字符串 就是拼接了
如果使用var关键词定义的字符串即为可修改的变长字符串，而let关键词定义的字符串是常量字符串，不可修改。
*/
var variableStr = "hello"
variableStr += "world"
//使用append方法添加字符
let cate:Character = "!"
variableStr.append(cate)
variableStr.appendContentsOf("heheh😊🐨")

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
4.字符
Swift的字符串String就是由字符Character组成的，每一个Character都代表了一个特定的Unicode字符。通过for-in循环，可以遍历字符串中的每一个字符：
*/
for char in variableStr.characters {
    print(char);
}
//字符计数
let countStr = variableStr.characters.count

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
5.字符串比较
Swift提供三种方法比较字符串的值：字符串相等，前缀相等，和后缀相等
字符串相等
当两个字符串的包含完全相同的字符时，他们被判断为相等。
*/
let firstStr = "name"
let scondStr = "class"
if firstStr == scondStr {
 print("\(firstStr) is \(scondStr)")
}else{
  print("\(firstStr) isNotEqual \(scondStr)")
}
//是否是以na为前缀
if firstStr.hasPrefix("na"){
  print("\(firstStr) is hasPrefix na")
}else{
    print("\(firstStr) is not hasPrefix na")

}
//是否是以me为后缀
if firstStr.hasSuffix("m") {
    print("\(firstStr) is hasSuffix me")
}else{
    print("\(firstStr) is not hasSuffix me")
    
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
6.字符串修改
*/
firstStr.startIndex
firstStr[firstStr.startIndex]
firstStr.endIndex
firstStr[firstStr.endIndex.predecessor()]
firstStr[firstStr.startIndex.successor()]
let index = firstStr.startIndex.advancedBy(2)
firstStr[index]
for indexRan in firstStr.characters.indices{
    print("\(firstStr[indexRan])的位置下标为\(indexRan)")
}
//插入删除 必须是可变字符
var insterStr = "hello"
insterStr.insert("!", atIndex: insterStr.endIndex)
insterStr.insertContentsOf(" world".characters, at: insterStr.endIndex.predecessor())

let removeIndex = insterStr.startIndex.advancedBy(2)
insterStr.removeAtIndex(removeIndex)
print(insterStr)

let endIndex = insterStr.endIndex.advancedBy(-3)

//let range = Range(start: removeIndex,end: endIndex)
let range = removeIndex..<endIndex
insterStr.removeRange(range)
print(insterStr)

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
7.字符串大小写
你可以从一个String类型的uppercaseString 和 lowercaseString中获得一个字符串的大写或小写。
*/
let upperStr = firstStr.uppercaseString
let lower = firstStr.lowercaseString

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
8.Unicode
不懂的自行百度吧

Swift 支持多种不同的方式取得Unicode字符串.
你可以使用for-in语句遍历字符串，来获得每一个字符的Unicode编码值。这个过程已经在字符（Working with Characters）描述过了。
或者，下面三个描述中使用合适的一个来获得一个字符串的值
UTF-8字符编码单元集合使用String类型的utf-8属性
UTF-16字符编码单元集合使用String类型的utf-16属性
21位Unicode标量集合使用String类型的unicodeScalars属性
下面的每一个例子展示了不同编码显示由 D , o , g , !

（DOG FACE, 或者Unicode标量 U+1F436）字符组成的字符串
*/
let dogString = "Dog‼🐶"
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
