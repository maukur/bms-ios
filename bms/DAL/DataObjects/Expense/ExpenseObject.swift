import Foundation

struct ExpenseObject:Codable {
    let id :String
    let description:String
    let date:Date
    let amount: Double
    let status: StatusEnum
}

