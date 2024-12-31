import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    let onBack: () -> Void
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                    Text("Retour")
                }
                Spacer()
                Text("Paramètres")
                    .font(.headline)
                Spacer()
            }
            .padding()
            .background(Color(.systemBackground))
            
            // Form content
            Form {
                Section("Durées") {
                    NumberPickerView(
                        title: "Travail",
                        value: viewModel.workDuration,
                        range: 1...60,
                        unit: "min"
                    ) { newValue in
                        viewModel.updateWorkDuration(newValue)
                    }
                    
                    NumberPickerView(
                        title: "Pause courte",
                        value: viewModel.shortBreakDuration,
                        range: 1...30,
                        unit: "min"
                    ) { newValue in
                        viewModel.updateShortBreakDuration(newValue)
                    }
                    
                    NumberPickerView(
                        title: "Pause longue",
                        value: viewModel.longBreakDuration,
                        range: 1...45,
                        unit: "min"
                    ) { newValue in
                        viewModel.updateLongBreakDuration(newValue)
                    }
                }
                
                Section("Cycles") {
                    NumberPickerView(
                        title: "Cycles avant pause longue",
                        value: viewModel.cyclesBeforeLongBreak,
                        range: 1...10,
                        unit: "cycles"
                    ) { newValue in
                        viewModel.updateCyclesBeforeLongBreak(newValue)
                    }
                }
            }
        }
    }
} 