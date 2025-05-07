//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import Foundation

// MARK: - Protocol

/// A step in the fetch request building process.
public protocol RequestBuilderStep {}

/// Identifies a step where a sort step can be applied.
public protocol SortableStep {}


// MARK: - Steps

// Creation → Target → Predicate → Sort

/// The request has been created.
public enum CreationStep: RequestBuilderStep {}

/// The request has a target (first, first nth, all).
public enum TargetStep: RequestBuilderStep, SortableStep {}

/// The request has a predicate.
public enum PredicateStep: RequestBuilderStep, SortableStep {}

