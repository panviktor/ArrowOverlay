//
//  CurvedArrowBody.swift
//  ArrowOverlay
//
//  Created by Viktor on 17.02.2025.
//

import SwiftUI

// MARK: - Arrow Body (CurvedArrowBody)

/// A shape that draws an S-shaped (cubic Bezier) arrow between the points `start` and `end`.
/// The `end` point is extended by `lineExtension` so that the line goes "under" the arrow tip.
/// Control points (c1 and c2) are offset separately for the top and bottom parts.
struct CurvedArrowBody: Shape {
	let start: CGPoint
	let end: CGPoint
	let side: ArrowSide

	var lineExtension: CGFloat = 10
	var startOffset: CGFloat = 20
	var endOffset: CGFloat = 40

	func path(in rect: CGRect) -> Path {
		var path = Path()

		// Angle for extending the line under the arrow tip:
		// For .right, angle = 0 (line extends to the right);
		// For .left, angle = π (line extends to the left).
		let angle: CGFloat = (side == .right) ? 0 : .pi

		// "Final" end point: extend the original `end` by `lineExtension`
		let finalEnd = CGPoint(
			x: end.x + lineExtension * cos(angle),
			y: end.y + lineExtension * sin(angle)
		)

		path.move(to: start)

		// Separate the logic for the top and bottom control points.
		// You can experiment with these coefficients to adjust the curvature.
		let directionStart: CGFloat
		let directionEnd: CGFloat

		switch side {
		case .right:
			// Example: top control point offset coefficient +0.25, bottom +1.25.
			directionStart = +0.25
			directionEnd   = +1.25
		case .left:
			// For left arrow, use negative coefficients.
			directionStart = -0.25
			directionEnd   = -1.25
		}

		let c1 = CGPoint(
			x: start.x + directionStart * startOffset,
			y: start.y
		)

		let c2 = CGPoint(
			x: finalEnd.x + directionEnd * endOffset,
			y: finalEnd.y
		)

		path.addCurve(to: finalEnd, control1: c1, control2: c2)

		return path
	}
}
