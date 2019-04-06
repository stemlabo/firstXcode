import UIKit

class Dog {
    var name = ""
    func bark(){
        let message = name + ": Bow-wow!"
        print(message)
        
    }
}

class Shibainu: Dog {
    var age = 0
    func sayAge(){
        let message = name + ": I'\(age) years old."
        print(message)
    }
}

let taro = Shibainu()
taro.name = "Taro"
taro.age = 5
taro.bark()
taro.sayAge()
