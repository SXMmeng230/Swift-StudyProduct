//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//5 -控制流


import UIKit

var str = "Hello, playground"

/*Swift提供了所有C语言中相似的控制流结构。包括for和while循环；if和switch条件语句；break和continue跳转语句等。

Swift还加入了for-in循环语句，让编程人员可以在遍历数组，字典，范围，字符串或者其它序列时更加便捷。

相对于C语言，Swift中switch语句的case语句后，不会自动跳转到下一个语句，这样就避免了C语言中因为忘记break而造成的错误。另外case语句可以匹配多种类型，包括数据范围，元组，或者特定的类型等。switch语句中已匹配的数值也可以被用在后续的case语句体中，where关键词还能被加入任意的case语句中，来增加匹配的方式。
*/

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
1、for循环
for循环可以根据设置，重复执行一个代码块多次。Swift中提供了两种for循环方式：
for-in循环，对于数据范围，序列，集合等中的每一个元素，都执行一次
for-condition-increment，一直执行，知道一个特定的条件满足，每一次循环执行，都会增加一次计数
*/
for index in 1...5 {
print(index)
}
//如果你不需要序列中的每一个值，可以使用_来忽略它，仅仅只是使用循环体本身：
let base = 3
let power = 3
var answer = 1
for _ in 1...power{
  answer += base
}
print(answer)
//遍历字符串
for character in "hello".characters {
print(character)
}
for var index = 0;index < 3;index++ {
  print(index)
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
1、while循环
while循环执行一系列代码块，直到某个条件为false为止。这种循环最长用于循环的次数不确定的情况。Swift提供了两种while循环方式：
while循环，在每次循环开始前测试循环条件是否成立
do-while循环，在每次循环之后测试循环条件是否成立
*/
//下面是一个while循环的一般形式
//while condition {
//    statements
//}
/*
Do-while循环

另一种while循环是do-while循环。在这种循环中，循环体中的语句会先被执行一次，然后才开始检测循环条件是否满足，下面是do-while循环的一般形式：
*/
//do {
//    statements
//} while condition


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2.条件语句
*/
//if语句
//在最基本的if语句中，条件语句只有一个，如果条件为true时，执行if语句块中的语句：
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
//switch语句
//switch语句考察一个值的多种可能性，将它与多个case相比较，从而决定执行哪一个分支的代码。switch语句和if语句不同的是，它还可以提供多种情况同时匹配时，执行多个语句块。
//下面的例子用switch语句来判断一个字符的类型：

let someCharachter:Character = "a"
switch someCharachter {
case "a","b","c":
    print("匹配")
default: //一般不会省略,只要完全确定了所有的可能性,就可以省略
    print("不匹配")
}
//省略default
enum YY {
  case a
  case b
}
let aa:YY = .b
switch aa {
case .a:
    print(".a")
case .b:
    print(".b")
}
//注意:跟C和Objective-C不同，Swift中的switch语句不会因为在case语句的结尾没有break就跳转到下一个case语句执行。switch语句只会执行匹配上的case里的语句，然后就会直接停止。这样可以让switch语句更加安全，因为很多时候编程人员都会忘记写break。

//switch语句的case中可以匹配一个数值范围，比如：

let count = 3_000_000_000_000
let countedThings = "stars in the Milky Way"
var naturalCount: String
switch count {
case 0:
    naturalCount = "no"
case 1...3:
    naturalCount = "a few"
case 4...9:
    naturalCount = "several"
case 10...99:
    naturalCount = "tens of"
case 100...999:
    naturalCount = "hundreds of"
case 1000...999_999:
    naturalCount = "thousands of"
default:
    naturalCount = "millions and millions of"
}

//元组 case中还可以直接测试元组是否符合相应的条件，_可以匹配任意值。
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

//数值绑定 在case匹配的同时，可以将switch语句中的值绑定给一个特定的常量或者变量，以便在case的语句中使用。比如
let anotherPoint = (2, 6)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

//Where关键词 switch语句可以使用where关键词来增加判断的条件，在下面的例子中
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
3.控制跳转语句
在Swift中控制跳转语句有4种，让编程人员更好地控制代码的流转，包括：

continue

break

fallthrough

return
*/

//continue语句告诉一个循环停止现在在执行的语句，开始下一次循环
//break语句将终止整个循环的执行，可以用在循环语句中，也可以用在switch语句中。

//由于Swift中的switch语句不会自动的因为没有break而跳转到下一个case，因此如果需要想C语言中那样，依次执行每个case的时候，就需要用到fallthrough关键词。
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)

//带标签语句
//switch和循环可以互相嵌套，循环之间也可以互相嵌套，因此在使用break或者continue的时候，需要知道到底是对哪个语句起作用。这就需要用到标签语句。标签语句的一般形式如下
/*
label name: while condition {
statements
}
*/
let finalSquare = 25
var board = [Int](count: finalSquare + 1, repeatedValue: 0)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
gameLoop: while square != finalSquare {
    if ++diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")
//注:在这个代码中，将游戏的循环命名为gameLoop，然后在每一步移动格子时，判断当前是否到达了游戏终点，在break的时候，需要将整个游戏循环终止掉，而不是终止switch，因此用到了break gameLoop。同样的，在第二个分支中，continue gameLoop也指明了需要continue的是整个游戏，而不是switch语句本身

//guard语法，与if类似，都是更具一个布尔语句的结果执行。不同的是，为了能够保证guard后的代码能够执行，你必须保障guard中的条件是true。否则将会执行else的内容（else必须存在）
func greet(person: [String: String]){
    guard let name = person["name"] else  {
        return
    }
    print("Hello \(name)!")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}

greet(["name":"John"])
greet(["name":"Jane", "location": "Cupertino"])
