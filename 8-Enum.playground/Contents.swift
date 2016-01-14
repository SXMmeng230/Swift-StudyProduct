//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//8-枚举
import UIKit

var str = "Hello, playground"

//枚举定义了一个常用的具有相关性的一组数据，并在你的代码中以一个安全的方式使用它们。
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
1、枚举语法 
使用枚举enum关键词并把他们的整个定义在一对大括号内：
*/
enum SomeEnumeration {
    // enumeration definition goes here
}
enum CompassPoint {
    case North
    case South
    case East
    case West
}
//注意 :不像C和Objective-C，Swift枚举成员在创建时不分配默认整数值。在上面的例子CompassPoints中North，South，Eath，West不等于隐含0，1，2和3，而是一种与CompassPoint明确被定义的类型却各不相同的值。
//多个成员的值可以出现在一行上，用逗号分隔：
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
var directionToHead = CompassPoint.West
directionToHead = .East


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2、匹配枚举值与switch语句
你可以使用单个枚举值匹配switch语句：
*/
directionToHead = .South
switch directionToHead {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}
//当它不需要为每一个枚举成员都匹配的情况下，你可以提供一个默认default分支来涵盖未明确提到的任何成员
let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
3、关联值
*/
//在Swift中可以使用一个枚举来定义两种类型的产品条形码，结构可以是这样的：
enum Barcode {
    case UPCA(Int, Int, Int)
    case QRCode(String)
}
var productBarcode = Barcode.UPCA(8, 85909_51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
switch productBarcode {
case .UPCA(let numberSystem, let identifier, let check):
    print("UPC-A with value of \(numberSystem), \(identifier), \(check).")
case .QRCode(let productCode):
    print("QR code with value of \(productCode).")
}
//如果所有的枚举成员的关联值的提取为常数，或者当所有被提取为变量，为了简洁起见，可以放置一个var，或let标注在成员名称前:
switch productBarcode {
case let .UPCA(numberSystem, identifier, check):
    print("UPC-A with value of \(numberSystem), \(identifier), \(check).")
case let .QRCode(productCode):
    print("QR code with value of \(productCode).")
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
4、原始值
在关联值的条形码的例子演示了一个枚举的成员如何能声明它们存储不同类型的关联值。作为替代关联值，枚举成员可以拿出预先填入缺省值（称为原始值），从而具有相同的类型。
*/
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

enum PlanetNumber: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
//自动递增意味着Planet.Venus具有2的原始值，依此类推。
let earthsOrder = PlanetNumber.Earth.rawValue
let marsValue = PlanetNumber(rawValue: 4)


