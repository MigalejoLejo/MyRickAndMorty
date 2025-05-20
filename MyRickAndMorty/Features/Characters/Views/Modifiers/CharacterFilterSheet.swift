//
//  FilterSheet.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 21.05.2025.
//
import SwiftUI

struct FilterSheetModifier: ViewModifier {
    @ObservedObject var viewModel: CharacterListViewModel

    func body(content: Content) -> some View {
        content.sheet(isPresented: $viewModel.isShowingFilterSheet) {
            CharacterFilterView(
                filters: $viewModel.filter,
                onSubmit: {
                    viewModel.isShowingFilterSheet = false
                    Task { await viewModel.applyFilters() }
                },
                onClear: {
                    viewModel.isShowingFilterSheet = false
                    viewModel.filter = CharacterFilter()
                    Task { await viewModel.applyFilters() }
                }
            )
        }
    }
}

extension View {
    func characterFilterSheet(using viewModel: CharacterListViewModel) -> some View {
        self.modifier(FilterSheetModifier(viewModel: viewModel))
    }
}
