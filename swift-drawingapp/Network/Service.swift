//
//  Service.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

final class Service {
    private(set) var repositoryInPort: RepositoryInPort?

    init() {
        ChatClient.local?.fetchedData = { [weak self] command in
            guard
                let data = command.data,
                let pictures = try? JSONDecoder().decode([Picture].self, from: data)
            else { return }
            self?.repositoryInPort?.addPictures(pictures)
        }
    }

    func setRepositoryInPort(_ repositoryInPort: RepositoryInPort) {
        self.repositoryInPort = repositoryInPort
    }
}

extension Service: NetworkOutPort {
    func login() async -> Bool {
        await ChatClient.local?.connect() ?? false
    }
}

extension Service: RepositoryOutPort {
    func save(pictures: [Picture]) {
        let picturesData = try? JSONEncoder().encode(pictures)
        let command = Command(header: Request.Chat, id: UUID().uuidString, length: nil, data: picturesData)
        guard let data = try? JSONEncoder().encode(command) else { return }
        ChatClient.local?.send(data: data)
    }
}
