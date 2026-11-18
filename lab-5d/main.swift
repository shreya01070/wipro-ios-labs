import Foundation

// Task 1: Unsafe Counter

class UnsafeCounter {
    var count = 0

    func increment() {
        let oldValue = count

        // Small delay to show the race condition
        Thread.sleep(forTimeInterval: 0.0001)

        count = oldValue + 1
    }
}

func testUnsafeCounter() {
    print("Starting unsafe counter test...")

    let counter = UnsafeCounter()
    let queue = DispatchQueue(label: "counterQueue", attributes: .concurrent)
    let group = DispatchGroup()

    for _ in 0..<100 {
        queue.async(group: group) {
            counter.increment()
        }
    }

    group.wait()

    print("Expected count: 100")
    print("Actual count: \(counter.count)\n")
}


// Task 2: Safe Counter using Actor

actor SafeCounter {
    private var count = 0

    func increment() {
        count += 1
    }

    func getCount() -> Int {
        return count
    }
}

func testSafeCounter() async {
    print("Starting safe counter test...")

    let counter = SafeCounter()

    await withTaskGroup(of: Void.self) { group in
        for _ in 0..<100 {
            group.addTask {
                await counter.increment()
            }
        }
    }

    let result = await counter.getCount()

    print("Final safe counter count: \(result)\n")
}


// Calling both tests

testUnsafeCounter()

Task {
    await testSafeCounter()
}
