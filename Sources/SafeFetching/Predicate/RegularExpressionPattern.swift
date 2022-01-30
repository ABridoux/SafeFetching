//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import Foundation

extension Builders {

    /// Holds a regular expression pattern
    ///
    /// - note: This wrapper mainly exists to offer a way to specify patterns in extensions, while
    /// preventing those extensions to be on `String`
    public struct RegularExpressionPattern {
        public let stringValue: String

        public init(pattern: String) {
            stringValue = pattern
        }
    }
}

extension Builders.RegularExpressionPattern: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        stringValue = value
    }
}

