import Foundation

struct ExpenseDetailObject: Codable {
    let id: String
    var description: String
    var date: Date
    var amount: Double
    var expenseCategoryId: String
    var currencyId: String
    var paymentMethodId: String
    var image: Data?
    var status: StatusEnum
}
