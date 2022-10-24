//
//  AnyAsyncSequence.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/24.
//

import Foundation

struct AnyAsyncIterator<Element>: AsyncIteratorProtocol {
    private let wrappedNext: () async throws -> Element?

    init<I: AsyncIteratorProtocol>(_ asyncIterator: I) where I.Element == Element {
        var asyncIterator = asyncIterator
        wrappedNext = { try await asyncIterator.next() }
    }

    mutating func next() async throws -> Element? {
        try await wrappedNext()
    }
}

struct AnyAsyncSequence<Element>: AsyncSequence {
    typealias AsyncIterator = AnyAsyncIterator<Element>

    private let wrappedMakeAsyncIterator: AsyncIterator

    init<S: AsyncSequence>(_ asyncSequence: S) where S.AsyncIterator.Element == AsyncIterator.Element {
        wrappedMakeAsyncIterator = AnyAsyncIterator(asyncSequence.makeAsyncIterator())
    }

    __consuming func makeAsyncIterator() -> AsyncIterator {
        wrappedMakeAsyncIterator
    }
}

extension AsyncSequence {
    func eraseToAnyAsyncSequence() -> AnyAsyncSequence<Element> {
        AnyAsyncSequence(self)
    }
}
