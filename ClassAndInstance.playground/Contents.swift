import UIKit

class Dog {
    var name = ""
    func bark() {
        let message = name + ": Bow-wow!"
        print(message)
    }
}

let pochi = Dog()
pochi.name = "Pochi"
pochi.bark()

let hachi = Dog()
hachi.name = "Hachi"
hachi.bark()
