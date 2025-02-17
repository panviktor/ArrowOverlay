---

# Animated Arrow Overlay

This project demonstrates an animated arrow overlay in SwiftUI using Anchor Preferences. The solution dynamically connects views (e.g. list items) with animated, curved arrows that draw themselves from start to finish. It encapsulates the arrow overlay logic in a reusable view modifier.

## Features

- **Dynamic Positioning:**  
  Uses SwiftUI Anchor Preferences to automatically capture view geometry, enabling arrow connections between arbitrary views (e.g. items in a `ScrollView` or `List`).

- **Reusable Components:**  
  The arrow drawing code is encapsulated in two custom shapes:  
  - `CurvedArrowBody` for drawing the S‑shaped arrow body.  
  - `HorizontalArrowTip` for drawing the triangular arrow tip, oriented strictly horizontally.

- **Declarative Configuration:**  
  Define arrow connections using the `ArrowSegment` model. Configure colors, offsets, arrow head dimensions, and more.

- **Animated Drawing:**  
  The arrow overlay is animated using the `.trim(from:to:)` modifier. Arrows animate from 0% to 100% drawn on view appearance (or upon reset).

- **Easy Integration:**  
  A custom view modifier (`ArrowsOverlayModifier`) is provided so that you can easily attach the arrow overlay to any view hierarchy.

## Usage

1. **Add Views:**  
   Use the `MyRow` view (or your custom view) to display your content. Each view registers its bounds via Anchor Preferences.

2. **Define Arrows:**  
   Create an array of `ArrowSegment` objects to declare which items should be connected and how they should be styled.

3. **Apply Modifier:**  
   Attach the `.arrowsOverlay(_:, progress:)` modifier to your container view. The modifier automatically retrieves item positions and draws the animated arrows.

Example:

```swift
struct AnchorPreferencesArrowsExample: View {
    let items: [Item] = [
        Item(id: 1, name: "First"),
        Item(id: 2, name: "Second"),
        Item(id: 3, name: "Third"),
        Item(id: 4, name: "Fourth"),
        Item(id: 5, name: "Fifth")
    ]
    
    let arrowSegments: [ArrowSegment] = [
        ArrowSegment(fromID: 2, toID: 4, side: .right, color: .red),
        ArrowSegment(fromID: 1, toID: 5, side: .left, color: .blue, endOffset: 50),
        ArrowSegment(fromID: 3, toID: 5, side: .right, color: .green, startOffset: 40, endOffset: 60, lineExtension: 16)
    ]
    
    @State private var arrowProgress: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                ForEach(items) { item in
                    MyRow(item: item)
                }
            }
            .padding()
        }
        .arrowsOverlay(arrowSegments, progress: arrowProgress)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                arrowProgress = 1
            }
        }
    }
}
```

## Installation

Simply add the provided SwiftUI files to your Xcode project. The solution is self-contained and does not require any external dependencies.

## Contributing

Contributions are welcome! If you have ideas for improvements or bug fixes, please open an issue or submit a pull request.

## License

This project is released under the MIT License.

---

This README provides a summary of the project's features, usage instructions, and details on how to integrate the animated arrow overlay into your SwiftUI projects. Feel free to modify or expand it based on your project needs.
