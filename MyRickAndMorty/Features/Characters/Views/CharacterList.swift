import SwiftUI

struct CharacterList: View {
    @EnvironmentObject var Characters: CharacterListViewModel
    var title: String = "Characters"
    var favoritesOnly: Bool = false
    
    
    
    var body: some View {
        ScrollView {
            // ERROR MESSAGE
            if Characters.characters.isEmpty, let error = Characters.errorMessage {
                ErrorMessage(viewModel: Characters, error: error)
            }
            // CONTENT
            LazyVStack(spacing: 16) {
                ForEach(Characters.characters.filter { favoritesOnly ? $0.isFavorite : (!Characters.onlyFavorites || $0.isFavorite) }, id: \.id) { character in
                    CharacterCard(character: character, favButtonAction: {
                        Characters.toggleFavorite(for: character.id)
                    })
                    .onAppear{
                        Characters.triggerLoadMoreCharacters(basedOn: character)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            
            if Characters.isLoading {
                ProgressView()
                    .padding()
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(title)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    Characters.isShowingFilterSheet = true
                } label: {
                    Image(systemName:Characters.filter.isEmpty ? "line.3.horizontal.decrease.circle" : "line.3.horizontal.decrease.circle.fill")
                        .foregroundColor(Characters.filter.isEmpty ? .primary : .blue)

                }
                .buttonStyle(.plain)

                
                if !favoritesOnly {
                    Toggle(isOn: $Characters.onlyFavorites) {
                        Image(systemName: Characters.onlyFavorites ? "heart.fill" : "heart")
                            .foregroundColor( Characters.onlyFavorites ? .red : .black)
                    }
                    .padding(.trailing, 20)
                    .toggleStyle(.button)
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .task {
            await Characters.loadInitialCharacters()
        }
        .characterFilterSheet(using: Characters)
    }
}





#Preview {
    NavigationView{
        CharacterList()
            .environmentObject(CharacterListViewModel())
    }
}
    

struct ErrorMessage: View {
    let viewModel: CharacterListViewModel
    let error: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName:viewModel.errorIcon ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(viewModel.errorColor)
            
            Text("Oops! Something went wrong.")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(error)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                Task {
                    await viewModel.retry()
                    await viewModel.loadInitialCharacters()
                }
            }) {
                Text("Retry")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
