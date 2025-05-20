import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel(service: APIServiceDelayed.shared)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.characters) { character in
                        NavigationLink {
                            CharacterDetailView(character: character)
                        } label: {
                            CharacterCard(character: character)
                                .onAppear{
                                    viewModel.triggerLoadMoreCharacters(basedOn: character)
                                }
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .navigationTitle("Characters")
            .task {
                await viewModel.loadInitialCharacters()
            }
        }
    }
}

#Preview {
    CharacterListView()
}
