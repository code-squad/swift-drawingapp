//
//  SyncUseCase.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/31.
//

import Foundation

protocol SyncUseCase {
    
    var currentLoggedInUser: User? { get }
    
    func create(id: String) -> User
    
    func login(user: User, drawing: Drawing)
    
    func logout(user: User)
    
    func start(by user: User?)
    
    func setRespository(with port: ChatRepositoryPort)
}
