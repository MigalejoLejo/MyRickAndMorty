import SwiftUI

struct CharacterList: View {
    @StateObject private var viewModel: CharacterListViewModel
    
    init() {
        let service: CharacterService
        if CommandLine.arguments.contains("--UITest_ShowError") {
            service = APIServiceMock(shouldFail: true)
        } else if CommandLine.arguments.contains("--UITest_SuccessState") {
            service = APIServiceMock(shouldFail: false)
        } else {
            service = APIService.shared
        }
        
        _viewModel = StateObject(wrappedValue: CharacterListViewModel(service: service))
    }
    
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                // ERROR MESSAGE
                if viewModel.characters.isEmpty, let error = viewModel.errorMessage {
                    ErrorMessage(viewModel: viewModel, error: error)
                }
                
                
                // CONTENT
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.characters, id: \.id) { character in                        NavigationLink {
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
            .toolbar {
                Button {
                    viewModel.isShowingFilterSheet = true
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
            .task {
                await viewModel.loadInitialCharacters()
            }
        }
        .characterFilterSheet(using: viewModel)
    }
}





#Preview {
    CharacterList()
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
