//
//  ItemAnchorData.swift
//  ArrowOverlay
//
//  Created by Viktor on 17.02.2025.
//

import SwiftUI

/// For each item we store its id and its bounds (Anchor<CGRect>).
struct ItemAnchorData: Equatable {
	let id: Int
	let bounds: Anchor<CGRect>
}

/// A PreferenceKey to collect all ItemAnchorData in an array.
struct ItemAnchorKey: PreferenceKey {
	static let defaultValue: [ItemAnchorData] = []

	static func reduce(value: inout [ItemAnchorData], nextValue: () -> [ItemAnchorData]) {
		value.append(contentsOf: nextValue())
	}
}
