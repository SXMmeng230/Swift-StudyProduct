//: Playground - noun: a place where people can play


/*
初学swift基础知识,还有需要完善的地方,欢迎各位指导.QQ:2302926920
github地址:https://github.com/SXMmeng230/Swift-StudyProduct

*/



//12 - 下标语法
import UIKit

var str = "Hello, playground"

//类，结构和枚举类型都可以通过定义下标来访问一组或者一个序列中的成员元素。通过下标索引就可以方便地检索和设置相应的值，而不需要其他的额外操作。比如你可以通过someArray[index]来访问数组中的元素，或者someDictionary[key]来对字典进行索引。
//你可以为一个类型定义多个下标，以及适当的下标重载用来根据传递给下标的索引来设置相应的值。下标不仅可以定义为一维的，还可以根据需要定义为多维的，多个参数的

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
1.下标语法
下标可以让你通过实例名后加中括号内一个或多个数值的形式检索一个元素。语法和方法语法和属性语法类似，通过使用subscript关键定义，一个或多个输入参数以及一个返回值。不同于实例方法的是，下标可以是可读写的或者只读的。这种行为通过一个getter和setter语句联通，就像是计算属性一样。
*/
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
2、下标的使用
下标的具体含义由使用它时的上下文来确定。下标主要用来作为集合，列表和序列的元素快捷方式。你可以自由的为你的类或者结构定义你所需要的下标。
*/

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
3、下标选项

下标可以接收任意数量的参数，参数的类型也可以各异。下标还可以返回任何类型的值。下标可以使用变量参数或者可变参数，但是不能够使用输入输出参数或者提供默认参数的值。
类或者结构可以根据需要实现各种下标方式，可以在需要的时候使用合适的下标通过中括号中的参数返回需要的值。这种多下标的定义被称作下标重载。

*/
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0,1] = 1.5
//如果访问的矩阵越界的时候，断言就会被触发：
//let someValue = matrix[2, 2]
