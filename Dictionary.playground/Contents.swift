import UIKit

let a = ["Taro": 1985, "Hanako": 1986]

let b = a["Taro"]
let c = a["Hanako"]


var d: [String: Int] = ["Taro": 1985, "Hanako": 1986]
d["Jiro"] = 1988
d
d["Taro"] = 1984
d.removeValue(forKey: "Hanako")
d
