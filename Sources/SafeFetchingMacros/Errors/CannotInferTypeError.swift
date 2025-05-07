//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SwiftDiagnostics

// MARK: - CannotInferTypeError

struct CannotInferTypeError: Error {

    let macroName: String
    let variableName: String
}

// MARK: - Description

extension CannotInferTypeError: CustomStringConvertible {

    var description: String {
        "Type of '\(variableName)' cannot be inferred by the @\(macroName) macro"
    }
}

// MARK: - ID

extension CannotInferTypeError {

    var id: String { "\(macroName)_cannotInferType_\(variableName)" }
}

// MARK: - DiagnosticMessage

extension CannotInferTypeError: DiagnosticMessage {

    var severity: DiagnosticSeverity { .error }
    var message: String { description }
    var diagnosticID: MessageID { MessageID(domain: "RecisioMacroError", id: id) }
}

// MARK: - FixIt

extension CannotInferTypeError {

    struct FixIt: FixItMessage {
        let message: String
        var fixItID: MessageID { MessageID(domain: "RecisioMacroError", id: message) }
    }
}

