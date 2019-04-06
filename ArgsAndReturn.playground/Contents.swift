import UIKit

let a = 4
let b = 6

func add1(c: Int, d: Int) {
    let e = c + d
    print(e)
}
add1(c: a, d: b)

func add2(c: Int, d: Int) -> Int {
    let e = c + d
    return e
}
let f = add2(c: a, d: b)
print(f)
