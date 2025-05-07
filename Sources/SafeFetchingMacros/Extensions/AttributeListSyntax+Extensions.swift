//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SwiftSyntax

extension AttributeListSyntax {

    public func contains(_ matchingAttribute: AttributeSyntax) -> Bool {
        let matchingName = matchingAttribute.attributeName.as(IdentifierTypeSyntax.self)?.name.text
        for attribute in self {
            let attributeName = attribute.as(AttributeSyntax.self)?.attributeName.as(IdentifierTypeSyntax.self)?.name.text
            if attributeName == matchingName {
                return true
            }
        }
        return false
    }
}
