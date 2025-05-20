//
//  test.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 21.05.2025.
//

import XCTest
@testable import MyRickAndMorty

final class CharacterListViewModelTests: XCTestCase {
    func testErrorState() async {
        // Mock service that fails
        let mockService: CharacterService = APIServiceMock(shouldFail: true)
        let viewModel = await CharacterListViewModel(service: mockService )
        
        await viewModel.loadInitialCharacters()
        
        await MainActor.run {
            XCTAssertTrue(viewModel.characters.isEmpty)
            XCTAssertNotNil(viewModel.errorMessage)
        }
    }
    
    func testSuccessState() async {
        // Mock service that returns one character
        let mockService: CharacterService = APIServiceMock(shouldFail: false)
        let viewModel = await CharacterListViewModel(service: mockService)
        
        await viewModel.loadInitialCharacters()
        
        await MainActor.run {
            XCTAssertEqual(viewModel.characters.count, 1)
            XCTAssertNil(viewModel.errorMessage)
        }
    }
    
}
