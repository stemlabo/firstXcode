import UIKit

let getAgeMessage = {(name: String, age: Int) -> String in
    let message = name + ": I'm \(age) years old."
//    クロージャに含まれる処理の内容
//    引数を受け取り返り処理をおこない値としてかえす
    return message
}


let result = getAgeMessage("Pochi", 5)
print(result)

func sayAge(name: String, age: Int, getMessage: (String, Int) -> String) {
    let message = getMessage(name, age)
    print(message)
}
sayAge(name: "Hachi", age: 12, getMessage: getAgeMessage)
