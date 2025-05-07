//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import Foundation
import SwiftDiagnostics

// MARK: - FetchableManagedObjectMacroError

enum FetchableManagedObjectMacroError: String, Error {
    case onlyApplicableToClass
}

// MARK: - Static

extension FetchableManagedObjectMacroError: CustomStringConvertible {

    var description: String {
        switch self {
        case .onlyApplicableToClass:
            "@FetchableManagedObject is only applicable to a class"
        }
    }
}

// MARK: - DiagnosticMessage

extension FetchableManagedObjectMacroError: DiagnosticMessage {

    var severity: DiagnosticSeverity { .error }
    var message: String { description }
    var diagnosticID: MessageID { MessageID(domain: "SafeFetchingMacroError", id: rawValue) }
}

