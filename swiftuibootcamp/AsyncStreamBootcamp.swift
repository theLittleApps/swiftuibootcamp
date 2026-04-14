//
//  AsyncStreamBootcamp.swift
//  swiftuibootcamp
//
//  Created by YEN-JU HUANG on 2026/4/14.
//

import SwiftUI

class AsyncStreamDataManager {
    
    func getAsyncStream() -> AsyncStream<Int> {
        AsyncStream { [weak self] continuation in
            self?.getFakeData { value in
                continuation.yield(value)
            } onFinish: { error in
                continuation.finish()
            }
        }
    }
    
    func getThrowingAsyncStream() -> AsyncThrowingStream<Int, Error> {
        AsyncThrowingStream { [weak self] continuation in
            self?.getFakeData { value in
                continuation.yield(value)
            } onFinish: { error in
                continuation.finish(throwing: error)
            }
        }
    }
    
    func getFakeData(
        newValue: @escaping (_ value: Int) -> Void,
        onFinish: @escaping (_ error: Error?) -> Void
    ) {
        let items: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item), execute: {
                newValue(item)
                print("NEW DATA: \(item)")
                
                if item == items.last {
                    onFinish(nil)
                }
            })
        }
    }
}

@MainActor
@Observable
final class AsyncStreamViewModel {
    
    let manager = AsyncStreamDataManager()
    private(set) var currentNumber: Int = 0
    
    func onViewAppear() {
//        manager.getFakeData { [weak self] value in
//            self?.currentNumber = value
//        }
        let task = Task {
//            for await value in manager.getAsyncStream() {
//                currentNumber = value
//            }
            do {
                for try await value in manager.getThrowingAsyncStream() {
                    currentNumber = value
                }
            } catch {
                print(error)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            task.cancel()
            print("TASK CANCELLED!")
        })
    }
    
}

struct AsyncStreamBootcamp: View {
    
    private var vm = AsyncStreamViewModel()
    
    var body: some View {
        Text("\(vm.currentNumber)")
            .font(.headline)
            .onAppear {
                vm.onViewAppear()
            }
    }
}

#Preview {
    AsyncStreamBootcamp()
}
