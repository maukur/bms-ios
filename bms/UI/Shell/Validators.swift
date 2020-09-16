//
//  Validators.swift
//  bms
//
//  Created by Sergey on 15.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation
import UIKit

class ValidationError: Error {
    var message: String
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case password
    case notNilOrEmpty
    case phoneNumber
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .notNilOrEmpty: return NotNilOrEmptyValidator()
        case .phoneNumber: return PhoneNuberValidator()
        }
    }
}

struct NotNilOrEmptyValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else { throw ValidationError("Invalid content") }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 6 else { throw ValidationError("Invalid password") }
        return value
    }
}

struct PhoneNuberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 10 && value.count <= 14 else { throw ValidationError("Invalid phone number") }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$",
                                       options: .caseInsensitive)
                .firstMatch(in: value,
                            options: [],
                            range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
        return value
    }
}

extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}
