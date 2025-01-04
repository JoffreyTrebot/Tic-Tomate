import SwiftUI

struct LandscapeView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            content
                .frame(
                    width: geometry.size.height,
                    height: geometry.size.width
                )
                .rotationEffect(.degrees(-90))
                .fixedSize()
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
        }
    }
} 