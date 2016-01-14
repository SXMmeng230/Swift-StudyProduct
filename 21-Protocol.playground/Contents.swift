//: Playground - noun: a place where people can play

/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//20 - 协议
import UIKit

var str = "Hello, playground"

//Protocol(协议)用于统一方法和属性的名称，而不实现任何功能。协议能够被类，枚举，结构体实现，满足协议要求的类，枚举，结构体被称为协议的遵循者。

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
1.协议的语法

协议的定义与类，结构体，枚举的定义非常相似，如下所示：

protocol SomeProtocol {
// 协议内容
}

在类，结构体，枚举的名称后加上协议名称，中间以冒号:分隔即可实现协议；实现多个协议时，各协议之间用逗号,分隔，如下所示：

struct SomeStructure: FirstProtocol, AnotherProtocol {
// 结构体内容
}

当某个类含有父类的同时并实现了协议，应当把父类放在所有的协议之前，如下所示：

class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
// 类的内容
}
*/


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
2.属性要求

协议能够要求其遵循者必须含有一些特定名称和类型的实例属性(instance property)或类属性 (type property)，也能够要求属性的(设置权限)settable 和(访问权限)gettable，但它不要求属性是存储型属性(stored property)还是计算型属性(calculate property)。

通常前置var关键字将属性声明为变量。在属性声明后写上{ get set }表示属性为可读写的。{ get }用来表示属性为可读的。即使你为可读的属性实现了setter方法，它也不会出错。

*/
protocol SomeProtocol {
    var musBeSettable : Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}


//用类来实现协议时，使用class关键字来表示该属性为类成员；用结构体或枚举实现协议时，则使用static关键字来表示：

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}
struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")

//Startship类遵循了FullyNamed协议
 class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil ) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return prefix! + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")

ncc1701.fullName

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
3.方法要求
协议能够要求其遵循者必备某些特定的实例方法和类方法。协议方法的声明与普通方法声明相似，但它不需要方法内容。


*/
protocol SomeOtherProtocol {
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    func random() -> Double
}
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// 输出 : "Here's a random number: 0.37464991998171"
print("And another one: \(generator.random())")

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
4.突变方法要求
能在方法或函数内部改变实例类型的方法称为突变方法。在值类型(Value Type)(译者注：特指结构体和枚举)中的的函数前缀加上mutating关键字来表示该函数允许改变该实例和其属性的类型

用class实现协议中的mutating方法时，不用写mutating关键字；用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字。

*/

protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
5.协议类型

协议本身不实现任何功能，但你可以将它当做类型来使用。

使用场景：

作为函数，方法或构造器中的参数类型，返回值类型
作为常量，变量，属性的类型
作为数组，字典或其他容器中的元素类型
*/
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
var d6 = Dice(sides: 6,generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
6.委托(代理)模式

委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能交由(委托)给其他的类型。

委托模式的实现很简单： 定义协议来封装那些需要被委托的函数和方法， 使其遵循者拥有这些被委托的函数和方法。

委托模式可以用来响应特定的动作或接收外部数据源提供的数据，而无需要知道外部数据源的类型。

*/
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        ++numberOfTurns
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
7.在扩展中添加协议成员

即便无法修改源代码，依然可以通过扩展(Extension)来扩充已存在类型
*/
protocol TextRepresentable {
    func asText() -> String
}
extension Dice: TextRepresentable {
    func asText() -> String {
    return "A \(sides)-sided dice"
    }
}
let d12 = Dice(sides: 12,generator: LinearCongruentialGenerator())
print(d12.asText())

//SnakesAndLadders类也可以通过扩展的方式来遵循协议：

extension SnakesAndLadders: TextRepresentable {
    func asText() -> String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.asText())

//通过延展补充协议声明

//当一个类型已经实现了协议中的所有要求，却没有声明时，可以通过扩展来补充协议声明

struct Hamster {
    var name: String
    func asText() -> String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
8.集合中的协议类型
协议类型可以被集合使用，表示集合中的元素均为协议类型：

*/
let things: [TextRepresentable] = [game,d12]
for thing in things {
    print(thing.asText())
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
9.协议的继承

协议能够继承一到多个其他协议。语法与类的继承相似，多个协议间用逗号,分隔

*/
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 协议定义
}

protocol PrettyTextRepresentable: TextRepresentable {
    func asPrettyText() -> String
}
extension SnakesAndLadders: PrettyTextRepresentable {
    func asPrettyText() -> String {
        var output = asText() + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

print(game.asPrettyText())


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
10.协议合成

一个协议可由多个协议采用protocol<SomeProtocol, AnotherProtocol>这样的格式进行组合，称为协议合成(protocol composition)。
*/
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct SomePerson: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}
let birthdayPerson = SomePerson(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)

//wishHappyBirthday函数的形参celebrator的类型为protocol<Named,Aged>。可以传入任意遵循这两个协议的类型的实例



//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
11.检验协议的一致性

is操作符用来检查实例是否遵循了某个协议。
as?返回一个可选值，当实例遵循协议时，返回该协议类型；否则返回nil
as用以强制向下转换型。
*/
//@objc用来表示协议是可选的，也可以用来表示暴露给Objective-C的代码，此外，@objc型协议只对类有效，因此只能在类中检查协议的一致性。

protocol HasArea {
    var area: Double { get }
}
class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double {
        return pi * radius * radius
    }
    init(radius: Double) {
        self.radius = radius
    }
}
class Country: HasArea {
     var area: Double
    init(area: Double) {
        self.area = area
    }
}
class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
12.可选协议要求
可选协议含有可选成员，其遵循者可以选择是否实现这些成员。在协议中使用optional关键字作为前缀来定义可选成员。


*/
@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}
class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}
class ThreeSource: CounterDataSource {
    @objc let fixedIncrement = 3
}
var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: CounterDataSource {
    @objc func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}
