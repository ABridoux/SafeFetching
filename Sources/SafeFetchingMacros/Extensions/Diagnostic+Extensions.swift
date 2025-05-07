//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftCompilerPlugin

// MARK: - Diagnose

extension Diagnostic {

    static func readTypeOrDiagnose(
        binding patternBindingSyntax: PatternBindingSyntax,
        identifier identifierTypeSyntax: TokenSyntax,
        in context: some MacroExpansionContext,
        macroName: String
    ) -> TypeSyntax? {
        if let type = patternBindingSyntax.typeAnnotation?.type {
            return type
        } else if let type = patternBindingSyntax.initializer?.value.inferredType {
            return type
        }

        var fixedBinding = patternBindingSyntax
        fixedBinding.pattern.trailingTrivia = Trivia()
        fixedBinding.typeAnnotation = TypeAnnotationSyntax(
            colon: .colonToken(trailingTrivia: .space),
            type: TypeSyntax("<#type#>").with(\.trailingTrivia, .space)
        )

        context.diagnose(
            .init(
                node: patternBindingSyntax,
                message: CannotInferTypeError(macroName: macroName, variableName: identifierTypeSyntax.trimmedDescription),
                fixIt: FixIt(
                    message: CannotInferTypeError.FixIt(message: "Add explicit type declaration"),
                    changes: [
                        .replace(
                            oldNode: Syntax(patternBindingSyntax),
                            newNode: Syntax(fixedBinding)
                        )
                    ]
                )
            )
        )

        return nil
    }
}


