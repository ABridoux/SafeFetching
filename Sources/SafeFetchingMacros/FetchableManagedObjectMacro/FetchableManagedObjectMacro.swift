//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - FetchableManagedObjectMacro

public enum FetchableManagedObjectMacro {}

// MARK: - MemberMacro

extension FetchableManagedObjectMacro: MemberMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let classDecl = declaration.as(ClassDeclSyntax.self) else {
            throw FetchableManagedObjectMacroError.onlyApplicableToClass
        }

        let name = classDecl.name.trimmed
        let accessModifier = classDecl.accessModifier

        return try [
            DeclSyntax("\(accessModifier) static var fetchableMembers: FetchableMembers { FetchableMembers() }"),
            DeclSyntax(fetchableMembersStruct(
                for: declaration,
                name: name,
                accessModifier: accessModifier,
                context: context)
            )
        ]
    }
}

extension FetchableManagedObjectMacro {

    private static func fetchableMembersStruct(
        for groupDeclaration: some DeclGroupSyntax,
        name: TokenSyntax,
        accessModifier: DeclModifierSyntax,
        context: some MacroExpansionContext
    ) throws -> StructDeclSyntax {
        try StructDeclSyntax("\(accessModifier) struct FetchableMembers") {
            for member in groupDeclaration.memberBlock.members {
                if
                    let variableDecl = member.decl.as(VariableDeclSyntax.self),
                    variableDecl.attributes.contains(FetchingIgnoredMacro.ignoredAttribute) == false,
                    variableDecl.modifiers.contains(where: { $0.isPrivateAccessLevelModifier }) == false,
                    variableDecl.modifiers.contains(where: { $0.name.tokenKind == .keyword(.static) }) == false,
                    let identifier = variableDecl.firstIdentifier,
                    let type = variableDecl.firstTypeOrDiagnose(context: context, macroName: "FetchableManagedObject")
                {
                    let accessModifier = variableDecl.accessModifier.trimmed
                    try DeclSyntax(validating: #"\#(accessModifier) let \#(identifier) = FetchableMember<\#(name), \#(type)>(identifier: "\#(identifier)")"#)
                }
            }
        }
    }
}

// MARK: - ExtensionMacro

extension FetchableManagedObjectMacro: ExtensionMacro {

    public static func expansion(
        of _: SwiftSyntax.AttributeSyntax,
        attachedTo _: some SwiftSyntax.DeclGroupSyntax,
        providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
        conformingTo _: [SwiftSyntax.TypeSyntax],
        in _: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        let observableConformance = try ExtensionDeclSyntax("extension \(type): Fetchable") {}
        return [observableConformance]
    }
}
