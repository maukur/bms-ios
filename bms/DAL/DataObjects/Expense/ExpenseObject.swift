import Foundation

struct ExpenseObject:Codable {
    let id :String
    let description:String
    let date:String
    let amount: Int
    let status: String
}

