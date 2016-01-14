//: Playground - noun: a place where people can play



/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/



// 4- 集合,数组,字典
import UIKit

var str = "Hello, playground"

/*
Swift 提供两种集合类型来存储集合，数组和字典。数组是一个同类型的序列化列表集合。字典是一个能够使用类似于键的唯一标识符来获取值的非序列化集合。

在Swift中，数组和字典的键和值都必须明确它的类型。这意味这数组和字典不会插入一个错误的类型的值,以致于出错。这也意味着当你在数组和字典中取回数值的时候能够确定它的类型。
*/
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
1.数组
数组是储存同类型不同值的序列化列表。同样的值可以在数组的不同位置出现多次。

Swift数组是储存确定的值，这个Objective-C中的NSArray和NSMutableArray类是有区别的。因为它们是储存各种的对象，而且并不提供返回任何有关对象的具体信息。在Swift中，无论是确定的声明，还是隐式的声明，数组是非常确定它自身是储存什么样的类型，而且，它并不一定要求储存的是类对象。所以Swift数组是类型安全的，因为它一直都确定它自身所能包含的值。
*/
// 存储有序的同一种类型的值
var someInts = [Int]() // 等同于 Array<Int>()
someInts.append(3)
// 如果上下文已经清楚了Array中存储的类型，可以使用[]创建一个空Array，赋值给它
someInts = []
// 创建一个带默认值的数组
var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
for _ in 0...5 {
    threeDoubles.append(0.2)
}
threeDoubles


// 使用两个Array创建一个Array
var anotherThreeDoubles = [Double](count: 3, repeatedValue: 2.5)
var sixDoubles = threeDoubles + anotherThreeDoubles

var className:[String] = ["firstClass","scondClass"]
//var className:[String] = ["firstClass",3] 这样会报错,类型不匹配

//注意:var 表示可变数组,let 表示不可变数组,字典和这个一样

//得益于Swift的类型推断，当你用相同类型的值来初始化时，你可以不写明类型
var className1 = ["first","scond"]
//var className1 = ["first",30] 然而这个并不会报错,为啥呢?后面会说到

//1.1 数组操作
className.count //个数

if className.isEmpty{
print("数组是空的")
}else{
print("数组有值")
}
//添加元素
className.insert("sun", atIndex: 1)
//在数组最后添加
className.append("wang wu")
className += ["zhao liu"]

//取值
className[0]
//修改
className[0] = "wang ma zi"
className
print(className)
className[0..<1] = ["zhang san","li si"]
//注意:如果修改的区域小于要修改的值的个数,数组会自动添加所有要修改的值
print(className)
//移除
className.removeFirst(2) //移除前几个元素
className.removeFirst()//移除第一个元素
//注意:还有好多多移除方法,自行补脑
print(className)

//1.2数组遍历
for item in className{
print(item)
}
//如果需要每一个元素的整形的索引值，使用enumerate函数代替会更方便，enumerate函数对于每一个元素都会返回一个包含元素的索引和值的元组（tuple）。你可以在遍历部分分解元祖并储存在临时变量或者常量中
for (index,value) in className.enumerate(){
  print("\(index, value)")
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2.字典
字典是储存同一类型但是不同值的容器。每一个值都对应这一个唯一的键（Key），就像是字典内的每一个值都有一个标识符。和数组内的元素是有区别的，字典内的元素是没有特殊的序列的。当你需要根据标识符来查找批量的值时，就可以使用字典。同样的，真实
的物品字典常常用来当作查找特定字典的标识符。

Swift字典时储存一个类型的具体的键和值，和Objective-C的NSDictionary 和NSMutableDictionary由一定的区别，因为它们是使用各种的对象来作为它们的键和值，而且并不提供任何有关对象的具体信息。在Swift中，对于一个特定的字典，它所能储存的键和值都是确定的，无论是明确声明的类型还是隐式推断的类型。
*/
var namesDictionary = Dictionary<Int,String>()
var otherNameDictionary = [Int:String]()
namesDictionary[1] = "sun"
//namesDictionary = [:]
var anotherNameDictionary = ["sex1":"sun","sex2":"zhang"]
//修改和读取字典
anotherNameDictionary.count
let valueArr = Array(anotherNameDictionary.values)
print(valueArr)
let keyArr = Array(anotherNameDictionary.keys)
print(keyArr)
anotherNameDictionary["sex1"] = "wang" //如果存在sex1的key,就会更新值,否则就是添加新的键值对
print(anotherNameDictionary)


if let oldValue = anotherNameDictionary.updateValue("LIU", forKey: "sex3"){
  print("更新了\(oldValue)的值")
}else{
  print("新添加value值")
}
print(anotherNameDictionary)

anotherNameDictionary["sex1"]

//移除
anotherNameDictionary["sex1"] = nil
print(anotherNameDictionary)

//anotherNameDictionary.removeValueForKey("sex2")
//print(anotherNameDictionary)

//遍历字典
for (index,value) in anotherNameDictionary{
 print("下标\(index)的值为\(value)")
}
for keyValue in anotherNameDictionary.keys {
 print("所有的key值为\(keyValue)")
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2.集合
Set 无序存储相同类型的不同的值，存储值的类型必须是hashable的。Swift基本类型、枚举成员都是hashable的。
*/
var classSet = Set<Character>()
classSet.insert("b")
// 使用数组字面量创建Set Swift不能通过数组的字面量推断出Set类型，所以下面得Set声明不能省略，但是如果值是同一种类型，可以省略值类型
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
var anotherFavoriteGenres: Set = ["Rock", "Classical", "Hip hop"]

// 访问、修改Set
favoriteGenres.count
if favoriteGenres.isEmpty {
    print("I have \(favoriteGenres.count) favorite music genres.")
}

// 插入
favoriteGenres.insert("Jazz")

//删除 remove(_:) 返回一个optional
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}
// 包含
if favoriteGenres.contains("Hip hop") {
    print("I get up on the good foot.")
}

//迭代
for genre in favoriteGenres {
    print("\(genre)")
}
// 排序迭代
for genre in favoriteGenres.sort() {
    print("\(genre)")
}


let oddDigits: Set = [1, 3, 5, 7,4, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

// 并集
oddDigits.union(evenDigits).sort()
// 交集
oddDigits.intersect(evenDigits).sort()
// 补集
oddDigits.subtract(evenDigits).sort()

oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()

// 集合关系和比较
//使用“是否等”运算符(==)来判断两个集合是否包含相同的值。
//使用isSubsetOf(_:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
//使用isSupersetOf(_:)方法来判断一个集合中包含的值是另一个集合中所有的值。
//使用isStrictSubsetOf(_:)或者isStrictSupersetOf(_:)方法来判断一个集合是否是另外一个集合的子集合或者父集合,并且和特定集合不相等。
//使用isDisjointWith(_:)方法来判断两个集合是否不含有相同的值。
