//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SwiftSyntax

// MARK: - accessModifier

extension ClassDeclSyntax {

    /// Access modifier of the class, or `internal` when none is specified.
    var accessModifier: DeclModifierSyntax {
        guard let first = modifiers.first(where: { $0.isAccessLevelModifier }) else {
            return .internal
        }
        return first.trimmed
    }
}

