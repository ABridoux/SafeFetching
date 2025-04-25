//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import Foundation

extension KeyPath where Root: NSObject {

    /// Name of the property pointed at.
    var label: Substring {
        let description = String(describing: self)
        let prefixToDrop = "\\\(Root.self)."
        var value = description.dropFirst(prefixToDrop.count)
        value.removeAll { $0 == "?" }
        return value
    }
}
