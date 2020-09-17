//
//  LoginResponseConverter.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

//Other



//Calendar converters
extension EventDto {
    
    static let toObject = {(dto: EventDto) -> EventObject in
        EventObject(id: dto.id, reason: dto.reason, type: dto.type, status: dto.status)
    }
    
    static let toObjects = {(dto: [EventDto]) -> [EventObject] in
        var result: [EventObject] = []
        dto.forEach({d in
            result.append(EventDto.toObject(d))
        })
        return result
    }
}

extension EventCategoryDto {
    static let toObject = {(dto: EventCategoryDto) -> EventCategoryObject in
        EventCategoryObject(id: dto.id, name: dto.name)
    }
    
    static let toObjects = {(dto: [EventCategoryDto]) -> [EventCategoryObject] in
        var result: [EventCategoryObject] = []
        dto.forEach({ (d) in
            result.append(EventCategoryDto.toObject(d))
        })
        return result
    }
}

extension EventDetailDto {
    static let toObject = {(dto: EventDetailDto) -> EventDetailObject in
        EventDetailObject(id: dto.id, eventCategoryId: dto.eventCategoryId, reason: dto.reason, startDate: dto.startDate, endDate: dto.endDate, status: dto.status)
    }
}

//ExpenseConverter
extension ExpenseDto {
    static let toObject = {(dto: ExpenseDto) -> ExpenseObject in
        ExpenseObject(id: dto.id, description: dto.description, date: dto.date, amount: dto.amount, status: dto.status)
    }
    
    static let toObjects = {(dto: [ExpenseDto]) -> [ExpenseObject] in
        var result: [ExpenseObject] = []
        dto.forEach({d in
            result.append(ExpenseDto.toObject(d))
        })
        return result
    }
}

extension ExpenseGroupDto {
    static let toObject = {(dto: ExpenseGroupDto ) -> ExpenseGroupObject in
        ExpenseGroupObject(mounth: dto.mounth, expenses: dto.expenses)
    }
}

extension ExpenseCategoryDto {
    static let toObject = {(dto: ExpenseCategoryDto) -> ExpenseCategoryObject in
        ExpenseCategoryObject(name: dto.name, id: dto.id)
    }
    
    static let toObjects = {(dto: [ExpenseCategoryDto]) -> [ExpenseCategoryObject] in
        var result: [ExpenseCategoryObject] = []
        dto.forEach({d in
            result.append(ExpenseCategoryDto.toObject(d))
        })
        return result
    }
}

extension CurrencyDto {
    static let toObject = {(dto: CurrencyDto) -> CurrencyObject in
        CurrencyObject(name: dto.name, id: dto.id)
    }
    
    static let toObjects = {(dto: [CurrencyDto]) -> [CurrencyObject] in
        var result: [CurrencyObject] = []
        dto.forEach({d in
            result.append(CurrencyDto.toObject(d))
        })
        return result
    }
}

extension PaymentTypeDto {
    static let toObject = { (dto: PaymentTypeDto) -> PaymentTypeObject in
        PaymentTypeObject(name: dto.name, id: dto.id)
    }
    
    static let toObjects = { (dto: [PaymentTypeDto]) -> [PaymentTypeObject] in
        var result: [PaymentTypeObject] = []
        dto.forEach({d in
            result.append(PaymentTypeDto.toObject(d))
        })
        return result
    }
}

extension ExpenseDetailDto {
    static let toObject = {(dto: ExpenseDetailDto) -> ExpenseDetailObject in
        ExpenseDetailObject(id: dto.id, description: dto.description,
                            date: dto.date,
                            amount: dto.amount,
                            expenseCategoryId: dto.expenseCategoryId,
                            currencyId: dto.currencyId,
                            paymentMethodId: dto.paymentMethodId,
                            image: dto.image,
                            status: dto.status)
    }
    
    static let toObjects = {(dto: [ExpenseDetailDto]) -> [ExpenseDetailObject] in
        var result: [ExpenseDetailObject] = []
        dto.forEach({d in
            result.append(ExpenseDetailDto.toObject(d))
        })
        return result
    }
}

//User converters

extension LoginResponseDto {
    static let toObject = {
        (dto: LoginResponseDto) -> LoginResponseObject in
        return LoginResponseObject(token: dto.token)
        
    }
}

extension UserInfoDto {
    static let toObject = {(dto: UserInfoDto) -> UserInfoObject in
        UserInfoObject(fullName: dto.fullName,
                       birthDate: dto.birthDate,
                       employedDate: dto.employedDate,
                       email: dto.email,
                       phone: dto.phone)
        
    }
}
