//
//  SyncRepository.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

class SyncRepository {
    private weak var outPort: (RepositoryOutPort & NetworkOutPort)?
    private var inPort: DataInPort?

    func setInPort(_ inPort: DataInPort) {
        self.inPort = inPort
    }

    func setOutPort(_ outPort: RepositoryOutPort & NetworkOutPort) {
        self.outPort = outPort
    }
}

extension SyncRepository: DataOutPort {
    func login() async -> Bool {
        await outPort?.login() ?? false
    }

    func sendPictures(_ pictures: [Picture]) {
        outPort?.save(pictures: pictures)
    }
}

extension SyncRepository: RepositoryInPort {
    func addPictures(_ pictures: [Picture]) {
        inPort?.addPictures(pictures)
    }
}
