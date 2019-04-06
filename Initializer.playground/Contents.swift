import UIKit

class Dog {
    var name = ""
    var age = 0
    
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
}

let pochi = Dog(name: "Pochi", age: 5)
pochi.name
pochi.age
