import UIKit
//参照渡し
class Dog {
    var age = 0
}

var pochi = Dog()
pochi.age = 5

var hachi = pochi
hachi.age = 7

pochi.age
hachi.age

//値渡し
struct Cat {
    var age = 0
}
var tama = Cat()
tama.age = 5
 var mike = tama
mike.age = 7

tama.age
mike.age
tama.age
//値渡し
var a = 5
var b = a
b = 7
a
b
