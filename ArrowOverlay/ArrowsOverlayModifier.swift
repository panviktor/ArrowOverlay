//
//  ArrowsOverlayModifier.swift
//  ArrowOverlay
//
//  Created by Viktor on 17.02.2025.
//

import SwiftUI

// MARK: - Arrows Overlay Modifier

/// A custom view modifier that overlays arrows on top of the content.
/// It uses the ItemAnchorKey Preference to get element positions and draws the arrows.
/// The progress parameter (0...1) controls the drawing animation via .trim.
struct ArrowsOverlayModifier: ViewModifier {
	let arrowSegments: [ArrowSegment]
	let progress: CGFloat  // Animation progress (from 0 to 1)

	func body(content: Content) -> some View {
		content
			.overlayPreferenceValue(ItemAnchorKey.self) { anchors in
				GeometryReader { proxy in
					ZStack {
						ForEach(arrowSegments) { segment in
							if let fromAnchor = anchors.first(where: { $0.id == segment.fromID }),
							   let toAnchor = anchors.first(where: { $0.id == segment.toID }) {
								let fromRect = proxy[fromAnchor.bounds]
								let toRect = proxy[toAnchor.bounds]
								let margin: CGFloat = 10

								// For right arrow, use maxX+margin; for left, use minX-margin.
								let fromX = (segment.side == .right)
									? fromRect.maxX + margin
									: fromRect.minX - margin
								let fromY = fromRect.midY

								let toX = (segment.side == .right)
									? toRect.maxX + margin
									: toRect.minX - margin
								let toY = toRect.midY

								let startPoint = CGPoint(x: fromX, y: fromY)
								let endPoint = CGPoint(x: toX, y: toY)

								// Animate the arrow body using .trim.
								CurvedArrowBody(
									start: startPoint,
									end: endPoint,
									side: segment.side,
									lineExtension: segment.lineExtension,
									startOffset: segment.startOffset,
									endOffset: segment.endOffset
								)
								.trim(from: 0, to: progress)
								.stroke(segment.color,
										style: StrokeStyle(lineWidth: segment.lineWidth, lineCap: .round, lineJoin: .round))

								// Animate the arrow tip – you can adjust the trim start value if desired.
								HorizontalArrowTip(
									apex: endPoint,
									side: segment.side,
									arrowHeadLength: segment.arrowHeadLength,
									arrowHeadWidth: segment.arrowHeadWidth
								)
								.trim(from: 0.1, to: progress)
								.fill(segment.color)
							}
						}
					}
				}
			}
	}
}

extension View {
	func arrowsOverlay(_ arrowSegments: [ArrowSegment], progress: CGFloat) -> some View {
		self.modifier(ArrowsOverlayModifier(arrowSegments: arrowSegments, progress: progress))
	}
}
