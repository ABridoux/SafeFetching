//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros

// MARK: - Identifier and type

extension VariableDeclSyntax {

    /// property name
    public var firstIdentifier: TokenSyntax? {
        bindings
            .first?
            .identifier
    }

    /// property type
    public var firstType: TypeSyntax? {
        bindings
            .first?
            .typeAnnotation?
            .type
    }

    public func firstTypeOrDiagnose(context: some MacroExpansionContext, macroName: String) -> TypeSyntax? {
        guard let firstBinding = bindings.first else {
            return nil
        }

        if let firstType = firstBinding.typeAnnotation?.type {
            return firstType
        } else if
            let identifier = firstBinding.identifier,
            let type = Diagnostic.readTypeOrDiagnose(binding: firstBinding, identifier: identifier, in: context, macroName: macroName)
        {
            return type
        } else {
            return nil
        }
    }
}

// MARK: - Modifier

extension VariableDeclSyntax {

    /// First modifier found for the declaration, or `internal`.
    var accessModifier: DeclModifierSyntax {
        if modifiers.isEmpty {
            return .internal
        } else if modifiers.count == 1, let first = modifiers.first {
            if first.detail?.detail.tokenKind == .identifier("set") {
                return DeclModifierSyntax(name: .keyword(.internal))
            } else {
                return first
            }
        } else if modifiers.count == 2 {
            var index = modifiers.startIndex
            let firstModifier = modifiers[index]
            index = modifiers.index(after: index)
            let secondModifier = modifiers[index]
            if firstModifier.detail?.detail.tokenKind == .identifier("set") {
                return secondModifier
            } else {
                return firstModifier
            }
        }
        return .internal // not sure how this could happen
    }
}
