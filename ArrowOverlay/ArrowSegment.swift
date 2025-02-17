//
//  ArrowSegment.swift
//  ArrowOverlay
//
//  Created by Viktor on 17.02.2025.
//

import SwiftUI

// MARK: - ArrowSide and ArrowSegment

/// Indicates the side on which the arrow will be placed (left or right of an element).
enum ArrowSide {
	case left
	case right
}

/// A declarative description of an arrow between two items.
/// You can specify the color, offsets, and arrow head dimensions here.
struct ArrowSegment: Identifiable {
	let id = UUID()
	let fromID: Int
	let toID: Int
	let side: ArrowSide
	let color: Color

	var startOffset: CGFloat = 40      // Offset for the starting control point
	var endOffset: CGFloat = 40        // Offset for the ending control point
	var lineExtension: CGFloat = 12    // How much the line extends "under" the arrow tip
	var lineWidth: CGFloat = 6         // Arrow line thickness
	var arrowHeadLength: CGFloat = 16  // Arrow tip length
	var arrowHeadWidth: CGFloat = 12   // Arrow tip width
}
