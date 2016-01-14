//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/



//2- 基本运算符

import UIKit

var str = "Hello, playground"
/*
运算符是一种特定的符号或表达式，用来检验、修改或合并变量。例如，用求和运算符+可以对两个数字进行求和(如let i = 1 + 2)；稍微复杂一点的例子有逻辑与操作符&& (如if enteredDoorCode && passedRetinaScan) ，自增长运算符 ++i （这是i=i+1的简写方式）

操作符都是一元、二元或三元:

一元操作符操作单个对象 (如 -a)。一元前缀操作符出现在对象前(如 !b)，一元后缀操作符在对象后出现 (如 i++)。
二元操作符操作两个对象(如 2 + 3)，并且操作符位于两个元素中间。
三元操作符对两个对象进行操作。与C一样，Swift仅支持一个三元操作符：三元条件操作符 (a ? b : c).
操作符所影响的值被称为操作数。表达式1 + 2中，符号 + 是一个二元运算符并且两个操作数分别为 1 和 2。

*/


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
1.赋值运算符
赋值运算符(a = b) 用b的值去初始化或更新a 的值
*/
let b = 10
var a = 5
a = b
//假如右边赋值的数据为多个数据的元组，它的元素可以是一次性赋给的多个常量或变量
let (x,y) = (1,2)

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2.数字运算符
加法(+) *减法(-)
乘法(*)
除法(/)
*/
1 + 2
100 / 2.5

//字符串也可以用加法运算(字符串拼接),例如:
let hello = "hello "
let world = " world"
print("\(hello + world)")

//取余运算符
13 % 2
//不同于C和Objective-C，Swift的余数运算符也能运用于浮点数：
8 % 2.5

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
3.自增自减运算符
++a
--a
a++
a--
*/
var aa = 3
let bb = ++aa
//一元减运算符
let cc = -aa
//复合赋值操作符
 var dd = 0
dd += aa


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
4.比较运算符
等于 (a == b)
不等于(a != b)
大于 (a > b)
小于 (a < b)
大于等于 (a >= b)
小于等于(a <= b)
*/
//注:比较运算符也适用于字符串 例如
let name = "sun"
if name == "sun"{
print("very good")
}else{
 print("oh my god")
}
//三元条件运算符 这个想必大家都知道怎么用了,这里就简单说下
let isNumber = true
let numberGa = isNumber ? "yes":"no"


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
4.范围运算符
封闭范围运算符(a...b)
半封闭的区域运算符(a..<b)
*/
for index in 0...5{
    print(index);
}
//半封闭的范围使用明确，当你使用从零开始的列表，如数组，它是有用的数到(但不包括)列表的长度:
let names = ["aa","bb","cc","dd"]
let count = names.count
for i in 0..<count {
    print(names[i])
}


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
5.逻辑运算符
就是简单的 ! && || 运算符 直接copy网上的一些,自己感受下吧
*/
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
//对于复合运算符,建议加上（）使确逻辑意图更加明确
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

