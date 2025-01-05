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
            let size = min(geometry.size.width * 0.25, geometry.size.height * 0.5)
            
            HStack(spacing: size * 0.1) {
                // Minutes
                FlipDigitGroup(digits: minutes, digitSize: size)
                
                Text(":")
                    .font(.outfit(size * 0.8, weight: .bold))
                    .foregroundColor(.primary.opacity(0.5))
                
                // Seconds
                FlipDigitGroup(digits: seconds, digitSize: size)
            }
            .frame(maxWidth: .infinity)
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
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6).opacity(0.8))
                .frame(width: .infinity, height: .infinity)
            
            Text(digit)
                .font(.outfit(200, weight: .bold))
                .foregroundColor(.primary)
        }
    }
} 
