//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//14 - 初始化

import UIKit

var str = "Hello, playground"

//通过定义构造器（initializers）实现这个实例化过程，也就是创建一个新的具体实例的特殊方法。和Objective-C不一样的是，Swift的构造器没有返回值。它们主要充当的角色是确保这个实例在使用之前能正确的初始化
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
1、存储属性的初始化
构造器是创建一个具体类型实例的方法。最简单的构造器就是一个没有任何参数实例方法，写作init。
*/
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
//属性的默认值
//如上所述，你可以在构造器中设置它自己的储存属性的初始化值。或者在属性声明时，指定属性的默认值，你指定一个默认的属性值，会被分配到它定义的初始值。
//注意：如果一个属性常常使用同样的初始化值 ，提供一个默认值会比在初始化使用一个默认值会更好

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2、自定义初始化（Customizing Initialization）
你可以在构造器定义的时候提供一部分参数，在自定义初始化过程中定义变量的类型和名称。
初始化参和函数或者方法参数一样有着同样的功能。
*/
struct Celsius {
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius is 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

//实参名（Local Parameter Names）和形参名（External Parameter Names）
//和函数参数和方法参数一样，初始化参数拥有在构造器函数体使用的实参，和在调用时使用的形参
struct Color {
    var red = 0.0, green = 0.0, blue = 0.0
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}

//可选类型
//如果你储存属性使用的是自定义的类型在逻辑上允许值为空-或者他们的值并不在构造器中初始化，或者他们被允许为空。可以定义一个可选类型的属性。可选类型属性是一个自动初始化值为nil，表示这个属性有意在构造器中设置为“空值”（no value yet）。
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
3、默认构造器
Swift为每一个结构或者基类提供了默认的构造器，来初始化它们所包含的所有属性。默认构造器将会创建一个新的实例然后将它们的属性设置为默认值。
*/
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

//结构类型的成员逐一构造器

//除了上面提到的默认构造器之外，结构类型还有另外一种成员逐一完成初始化的构造器，可以在定义结构的时候直接指定每个属性的初始值。
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
4、数值类型的构造器代理
在实例的初始化过程中，构造器可以调用其他的构造器来完成初始化。这个过程叫构造器代理，可以避免多个构造器的重复代码。
对于数值类型来说，可以使用self.init来调用其他构造器，注意只能在这个数值类型内部调用相应的构造器。
*/

struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
5、类的继承和初始化

Swift为class类型定义了两种构造器来确保它们所有的存储属性都设置了初始值。这两种方式叫做指定构造器和便捷构造器。
指定构造器是一个类最主要的构造器。指定构造器通过设置所有属性的初值并且调用所有的父类构造器来根据构造链一次初始化所有的属性。

便捷构造器是类的第二种常用构造器。你可以调用同一个类中的指定构造器来定义一个便捷构造器，使用指定构造器来设置相关的参数默认值。你还可以定义一个便捷构造器来创建这个类的实例或者是别的特殊用途。

*/
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    convenience override init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let recipe = RecipeIngredient(name: "456")
recipe.name


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
6、通过闭包或者函数来设置一个默认属性值
如果存储属性的默认值需要额外的特殊设置，可以使用闭包或者函数来完成。

需要注意的是在闭包结尾有两个小括号，告诉Swift这个闭包是需要立即执行的。

注意：如果你时候闭包来初始化一个属性，在闭包执行的时候，后续的一些属性还没有被初始化。在闭包中不要访问任何后面的属性，一面发生错误，也不能使用self属性，或者其它实例方法。
*/
struct Checkerboard {
    var boardColors:[Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}
var board = Checkerboard()
print(board.squareIsBlackAtRow(0, column: 1))
board.boardColors[0] = false
// prints "true"
print(board.squareIsBlackAtRow(9, column: 9))

