//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SwiftSyntax

// MARK: - Inferred Type

extension ExprSyntax {

    /// The type of the expression syntax, if can be inferred.
    public var inferredType: TypeSyntax? {
        if self.is(IntegerLiteralExprSyntax.self) {
            return "Swift.Int"
        }
        if self.is(FloatLiteralExprSyntax.self) {
            return "Swift.Double"
        }
        if self.is(StringLiteralExprSyntax.self) ||
            self.is(SimpleStringLiteralExprSyntax.self) {
            return "Swift.String"
        }
        if self.is(BooleanLiteralExprSyntax.self) {
            return "Swift.Bool"
        }

        return nil
    }
}

