//: Playground - noun: a place where people can play

/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/


//17 - 可选链
import UIKit

var str = "Hello, playground"

//可选链（Optional Chaining）是一种可以请求和调用属性、方法及子脚本的过程，它的自判断性体现于请求或调用的目标当前可能为空（nil）。如果自判断的目标有值，那么调用就会成功；相反，如果选择的目标为空（nil），则这种调用将返回空（nil）。多次请求或调用可以被链接在一起形成一个链，如果任何一个节点为空（nil）将导致整个链失效。
//可选链可替代强制解析
//通过在想调用的属性、方法、或子脚本的可选值（optional value）（非空）后面放一个问号，可以定义一个可选链
class Person {
    var residence: Residence?
}
class Residence {
    var numberOfRooms = 1
}
//Residence具有一个Int类型的numberOfRooms，其值为 1。Person具有一个自判断residence属性，它的类型是Residence？。
//如果你创建一个新的Person实例，它的residence属性由于是被定义为自判断型的，此属性将默认初始化为空：
//如果你想使用感叹号（!）强制解析获得这个人residence属性numberOfRooms属性值，将会引发运行时错误，因为这时没有可以供解析的residence值。
let john = Person()
//let roomCount = john.residence!.numberOfRooms


//可选链提供了一种另一种获得numberOfRooms的方法。利用可选链，使用问号来代替原来!的位置：

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
//因为这种尝试获得numberOfRooms的操作有可能失败，可选链会返回Int?类型值，或者称作“自判断Int”。当residence是空的时候（上例），选择Int将会为空，因此会出先无法访问numberOfRooms的情况。

//要注意的是，即使numberOfRooms是非自判断Int（Int?）时这一点也成立。只要是通过可选链的请求就意味着最后numberOfRooms总是返回一个Int?而不是Int。

john.residence = Residence()
//john.residence 现在有了实际存在的实例而不是nil了。如果你想使用和前面一样的可选链来获得numberOfRoooms，它将返回一个包含默认值 1 的Int?：
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

//为可选链定义模型类

//你可以使用可选链来多层调用属性，方法，和子脚本。这让你可以利用它们之间的复杂模型来获取更底层的属性，并检查是否可以成功获取此类底层属性。

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if (buildingName != nil) {
            return buildingName
        } else if (buildingNumber != nil) {
            return buildingNumber
        } else {
            return nil
        }
    }
}
class SomePerson {
    var residence:SomeResidence?
}
class SomeResidence {
    var rooms = [Room]()
    var address:Address?
    var numberOfRoom:Int {
        return rooms.count
    }
    subscript(i:Int) ->Room{
    return rooms[i]
    }
    func printNumberOfRooms(){
        print("The number of rooms is \(numberOfRoom)")
    }
}
let someJohn = SomePerson()

//通过可选链调用方法
if let aa = someJohn.residence?.printNumberOfRooms() {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
//使用可选链调用子脚本
//你可以使用可选链来尝试从子脚本获取值并检查子脚本的调用是否成功，然而，你不能通过可选链来设置子代码。

if let firstRoomName = someJohn.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

//如果你创建一个Residence实例给john.residence，且在他的rooms数组中有一个或多个Room实例，那么你可以使用可选链通过Residence子脚本来获取在rooms数组中的实例了：

let johnsHouse = SomeResidence()
johnsHouse.rooms += [Room(name: "Living Room")]
johnsHouse.rooms += [Room(name: "Kitchen")]
someJohn.residence = johnsHouse

if let firstRoomName = someJohn.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

//连接多层链接
//你可以将多层可选链连接在一起，可以掘取模型内更下层的属性方法和子脚本。然而多层可选链不能再添加比已经返回的可选值更多的层。 也就是说：

//如果你试图获得的类型不是可选类型，由于使用了可选链它将变成可选类型。 如果你试图获得的类型已经是可选类型，由于可选链它也不会提高自判断性。

if let johnsStreet = someJohn.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

//如果你为Address设定一个实例来作为john.residence.address的值，并为address的street属性设定一个实际值，你可以通过多层可选链来得到这个属性值。

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
someJohn.residence!.address = johnsAddress

if let johnsStreet = someJohn.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
//值得注意的是，“!”符的在定义address实例时的使用（someJohn.residence.address）。someJohn.residence属性是一个可选类型，因此你需要在它获取address属性之前使用!解析以获得它的实际值。


//链接自判断返回值的方法

//下面的例子通过可选链调用了Address类中的buildingIdentifier 方法。这个方法的返回值类型是String?。如上所述，这个方法在可选链调用后最终的返回值类型依然是String?：

if let buildingIdentifier = someJohn.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}

//如果你还想进一步对方法返回值执行可选链，将可选链问号符放在方法括号的后面：

if let upper = someJohn.residence?.address?.buildingIdentifier()?.uppercaseString {
    print("John's uppercase building identifier is \(upper).")
}






