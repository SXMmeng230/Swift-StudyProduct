//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/

//18 - 类型检查
import UIKit

var str = "Hello, playground"

//类型检查是一种检查类实例的方式，并且或者也是让实例作为它的父类或者子类的一种方式。

//类型检查在 Swift 中使用is 和 as操作符实现。这两个操作符提供了一种简单达意的方式去检查值的类型或者转换它的类型。

//定义一个类层次作为例子

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}
class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//检查类型
//用类型检查操作符(is)来检查一个实例是否属于特定子类型。类型检查操作符返回 true 若实例属于那个子类型，若不属于返回 false 。
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        ++movieCount
    } else if item is Song {
        ++songCount
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs")

//向下转型（Downcasting）
//某类型的一个常量或变量可能在幕后实际上属于一个子类。你可以相信，上面就是这种情况。你可以尝试向下转到它的子类型，用类型检查操作符(as)

//因为向下转型可能会失败，类型检查操作符带有两种不同形式。可选形式（ optional form） as? 返回一个你试图下转成的类型的可选值（optional value）。强制形式 as 把试图向下转型和强制解包（force-unwraps）结果作为一个混合动作。

for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: '\(song.name)', by \(song.artist)")
    }
}

//转换没有真的改变实例或它的值。潜在的根本的实例保持不变；只是简单地把它作为它被转换成的类来使用。



//Any和AnyObject的类型检查

//Swift为不确定类型提供了两种特殊类型别名：
//AnyObject可以代表任何class类型的实例。
//Any可以表示任何类型，除了方法类型（function types）

//AnyObject类型

let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]
//因为知道这个数组只包含 Movie 实例，你可以直接用(as)下转并解包到不可选的Movie类型（ps：其实就是我们常用的正常类型，这里是为了和可选类型相对比）。

for object in someObjects {
    let movie = object as! Movie
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}
//为了变为一个更短的形式，下转someObjects数组为Movie[]类型来代替下转每一项方式。

for movie in someObjects as! [Movie] {
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}


//Any类型
//这里有个示例，使用 Any 类型来和混合的不同类型一起工作，包括非class类型。它创建了一个可以存储Any类型的数组 things。

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
//你可以在 switch cases里用is 和 as 操作符来发觉只知道是 Any 或 AnyObject的常量或变量的类型。

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    default:
        print("something else")
    }
}

//注意: 在一个switch语句的case中使用强制形式的类型检查操作符（as, 而不是 as?）来检查和转换到一个明确的类型。在 switch case 语句的内容中这种检查总是安全的。

