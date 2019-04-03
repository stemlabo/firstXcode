import UIKit

let a: [Int]  = [1, 2, 3, 4, 5]

let b = a[0]
let c = a[2]
let d = a[4]

var e = [1, 2, 3, 4, 5]
e.append(6)
e[2] = 9
e.remove(at: 3)
e
