import SwiftUI

struct NumberPickerView: View {
    let title: String
    let value: Int
    let range: ClosedRange<Int>
    let unit: String
    let onChange: (Int) -> Void
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Picker("", selection: Binding(
                get: { value },
                set: { onChange($0) }
            )) {
                ForEach(range, id: \.self) { number in
                    Text("\(number) \(unit)").tag(number)
                }
            }
            .pickerStyle(.menu)
        }
    }
} 