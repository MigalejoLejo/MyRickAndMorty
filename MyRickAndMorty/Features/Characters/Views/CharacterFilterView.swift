//
//  CharacterFilterView.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//
import SwiftUI

struct CharacterFilterView: View {
    @Binding var filters: CharacterFilter
    var onSubmit: () -> Void
    var onClear: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Search name", text: $filters.name)
                }
                
                Section(header: Text("Status")) {
                    Picker("Status", selection: $filters.status) {
                        Text("All").tag("all")
                        Text("Alive").tag("alive")
                        Text("Dead").tag("dead")
                        Text("Unknown").tag("unknown")
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Gender")) {
                    Picker("Gender", selection: $filters.gender) {
                        Text("All").tag("all")
                        Text("Male").tag("male")
                        Text("Female").tag("female")
                        Text("Genderless").tag("genderless")
                        Text("Unknown").tag("unknown")
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Button {
                        filters = CharacterFilter() // Reset all filters
                        onClear()
                    } label: {
                        Text("Clear Filters")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Filters")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        onSubmit()
                    }
                }
            }
        }
    }
}
#Preview {
    CharacterFilterView(
        filters: .constant(CharacterFilter()),
        onSubmit: {},
        onClear: {}

    )
}
