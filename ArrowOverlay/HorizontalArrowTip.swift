//
//  HorizontalArrowTip.swift
//  ArrowOverlay
//
//  Created by Viktor on 17.02.2025.
//

import SwiftUI

// MARK: - Arrow Tip (HorizontalArrowTip)

/// A shape that draws a triangular arrow tip, always oriented strictly horizontally.
/// For .right, the tip points to the right (angle = 0);
/// for .left, the tip points to the left (angle = π).
struct HorizontalArrowTip: Shape {
	let apex: CGPoint  // The point where the arrow tip touches the element
	let side: ArrowSide

	var arrowHeadLength: CGFloat = 10
	var arrowHeadWidth: CGFloat = 6

	func path(in rect: CGRect) -> Path {
		var path = Path()

		// Determine the angle: if .right, angle = 0 (points right); if .left, angle = π (points left).
		let angle: CGFloat = (side == .right) ? 0 : .pi

		let baseCenter = CGPoint(
			x: apex.x + arrowHeadLength * cos(angle),
			y: apex.y + arrowHeadLength * sin(angle)
		)

		let halfW = arrowHeadWidth / 2

		let corner1 = CGPoint(
			x: baseCenter.x + halfW * cos(angle + .pi / 2),
			y: baseCenter.y + halfW * sin(angle + .pi / 2)
		)
		let corner2 = CGPoint(
			x: baseCenter.x + halfW * cos(angle - .pi / 2),
			y: baseCenter.y + halfW * sin(angle - .pi / 2)
		)

		path.move(to: apex)
		path.addLine(to: corner1)
		path.addLine(to: corner2)
		path.closeSubpath()

		return path
	}
}

