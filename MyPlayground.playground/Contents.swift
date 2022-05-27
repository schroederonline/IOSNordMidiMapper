import UIKit

var greeting = "Hello, playground"

let list = Array<String> (arrayLiteral: "A", "B", "C");

list.map{(string) -> Int in
         string.count;
}
