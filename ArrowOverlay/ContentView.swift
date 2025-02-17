//
//  ContentView.swift
//  ArrowOverlay
//
//  Created by Viktor on 17.02.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		AnchorPreferencesArrowsExample()
    }
}

#Preview {
    ContentView()
}



// MARK: - Data Model and PreferenceKey

/// A simple data model representing an item.
struct Item: Identifiable {
	let id: Int
	let name: String
}




// MARK: - List Element (MyRow)

/// A simple view representing an item. It displays a Text with padding and background,
/// and registers its bounds via Anchor Preferences.
struct MyRow: View {
	let item: Item

	var body: some View {
		Text(item.name)
			.padding()
			.background(Color.yellow.opacity(0.2))
			.anchorPreference(key: ItemAnchorKey.self, value: .bounds) { anchor in
				[ItemAnchorData(id: self.item.id, bounds: anchor)]
			}
	}
}

// MARK: - Main View

struct AnchorPreferencesArrowsExample: View {
	// Sample data – a list of items.
	let items: [Item] = [
		Item(id: 1, name: "First"),
		Item(id: 2, name: "Second"),
		Item(id: 3, name: "Third"),
		Item(id: 4, name: "Fourth"),
		Item(id: 5, name: "Fifth")
	]

	// Arrow definitions between items.
	// For example:
	//  - A red arrow from the second to the fourth item, placed on the right.
	//  - A blue arrow from the first to the fifth item, placed on the left.
	//  - A green arrow from the third to the fifth item, placed on the right with stronger curvature.
	let arrowSegments: [ArrowSegment] = [
		ArrowSegment(fromID: 2, toID: 4, side: .right, color: .red),
		ArrowSegment(fromID: 1, toID: 5, side: .left, color: .blue, endOffset: 50),
		ArrowSegment(fromID: 3, toID: 5, side: .right, color: .green.opacity(0.5), startOffset: 40, endOffset: 60, lineExtension: 16)
	]

	// A state variable to control the animation progress (from 0 to 1)
	@State private var arrowProgress: CGFloat = 0

	var body: some View {
		ScrollView {
			VStack(spacing: 50) {
				ForEach(items) { item in
					MyRow(item: item)
				}
			}
			.padding()
			// A button to reset and reanimate the arrows.
			Button("Reset") {
				arrowProgress = 0
				withAnimation(.easeInOut(duration: 1.5)) {
					arrowProgress = 1
				}
			}
			.padding()
		}
		// Apply the custom modifier that overlays arrows (with animation)
		.arrowsOverlay(arrowSegments, progress: arrowProgress)
		.onAppear {
			withAnimation(.easeInOut(duration: 1.5)) {
				arrowProgress = 1
			}
		}
	}
}
