//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SwiftSyntax

extension PatternBindingSyntax {

    public var identifier: TokenSyntax? {
        pattern
            .as(IdentifierPatternSyntax.self)?
            .identifier
    }
}

