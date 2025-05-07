//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SwiftSyntax

extension DeclModifierSyntax {

    /// `true` if the modifier contains a public keyword.
    public var isNeededAccessLevelModifier: Bool {
        switch name.tokenKind {
        case .keyword(.public): true
        default: false
        }
    }

    /// `true` if the modifier contains a private keyword.
    public var isPrivateAccessLevelModifier: Bool {
        switch name.tokenKind {
        case .keyword(.private):
            if detail?.detail.tokenKind == .identifier("set") {
                return false
            }
            return true
        default:
            return false
        }
    }

    /// `true` if the modifier is an access modifier keyword (`public`, `private`...).
    public var isAccessLevelModifier: Bool {
        switch name.tokenKind {
        case let .keyword(keyword):
            [
                .private, .fileprivate,
                .internal, .package,
                .public
            ].contains(keyword)
        default:
            false
        }
    }
}

extension DeclModifierSyntax {

    static var `internal`: DeclModifierSyntax {
        DeclModifierSyntax(name: .keyword(.internal))
    }
}
