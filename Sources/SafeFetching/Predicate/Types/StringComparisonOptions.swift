//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

extension Builders {

    /// Available options to compare strings
    ///
    /// - [Reference](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html#//apple_ref/doc/uid/TP40001795-215868)
    /// - [CoreData - objc.io](https://www.objc.io/books/core-data/) (for the normalized option - chapter "Efficient Searching")
    public enum StringComparisonOptions {

        /// Diacritic insensitive
        case diacriticInsensitive

        /// Case insensitive
        case caseInsensitive

        /// Diacritic and case insensitive
        case diacriticAndCaseInsensitive

        /// Specify that the field is already normalized
        case normalized
    }
}

extension Builders.StringComparisonOptions {

    var stringValue: String {
        switch self {
        case .diacriticInsensitive: return "d"
        case .caseInsensitive: return "c"
        case .diacriticAndCaseInsensitive: return "cd"
        case .normalized: return "n"
        }
    }
}

extension Optional where Wrapped == Builders.StringComparisonOptions {

    /// If the option is not nil, add the flag to the operator. Otherwise return unchanged operator.
    func transformOperator(_ operatorString: String) -> String {
        switch self {
        case .none:
            return operatorString
        case let .some(wrapped):
            return "\(wrapped)[\(wrapped.stringValue)]"
        }
    }
}
