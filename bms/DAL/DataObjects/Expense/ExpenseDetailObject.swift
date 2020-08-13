import Foundation

struct ExpenseDetailObject : Codable {
    let id : String
    var description : String
    var date: String
   var price: Int
    var status, categoryId, currencyId, paymentTypeId: String
   var image: Data?
}

