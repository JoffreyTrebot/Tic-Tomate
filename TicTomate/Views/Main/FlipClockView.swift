import SwiftUI

struct FlipClockView: View {
    let timeString: String
    
    private var minutes: String {
        String(timeString.prefix(2))
    }
    
    private var seconds: String {
        String(timeString.suffix(2))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width * 0.2, geometry.size.height * 0.4)
            
            HStack(spacing: size * 0.1) {
                // Minutes
                FlipDigitGroup(digits: minutes, digitSize: size)
                
                Text(":")
                    .font(.system(size: size * 0.8, weight: .thin))
                    .foregroundColor(.primary)
                
                // Seconds
                FlipDigitGroup(digits: seconds, digitSize: size)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct FlipDigitGroup: View {
    let digits: String
    let digitSize: CGFloat
    
    var body: some View {
        HStack(spacing: digitSize * 0.05) {
            ForEach(Array(digits), id: \.self) { digit in
                FlipDigit(digit: String(digit), size: digitSize)
            }
        }
    }
}

struct FlipDigit: View {
    let digit: String
    let size: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.1)
                .fill(Color(.systemGray6))
                .frame(width: size, height: size * 1.5)
            
            Text(digit)
                .font(.system(size: size, weight: .light, design: .rounded))
                .foregroundColor(.primary)
        }
    }
} 