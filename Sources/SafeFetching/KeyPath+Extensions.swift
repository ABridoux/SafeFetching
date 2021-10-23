//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import Foundation

extension KeyPath where Root: NSObject {

    /// Name of the property pointed at
    /// - note: Will exit the program if the property is a computed one. The language allows
    /// to use a `KeyPath` with a computed property, but the  'Foundation' key paths will fail in that case.
    var label: String { NSExpression(forKeyPath: self).keyPath }
}
