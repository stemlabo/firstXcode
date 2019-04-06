import UIKit

var a: [Int] = []
for i in 0..<10 {
    if i%2 == 0 {
        a.append(i)
    }
}

a


var b :[Int] = []
for i in 0..<10 {
    if i%3 == 0 {
        b.append(i*3)
    }else{
        b.append(i)
    }
}
b
