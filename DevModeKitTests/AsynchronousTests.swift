@testable import DevModeKit
import XCTest

class AsynchronousTests: XCTestCase {
  
  private var operation = AsynchronousOperation { callback in }
  private var operationDidExecute = false
  
  override func setUp() {
    super.setUp()
    operationDidExecute = false
    operation = AsynchronousOperation(task: { callback in
      self.operationDidExecute = true
      callback()
    })
  }
  
  func testStart() {
    
    // Test initial state.
    assert(!operation.isFinished)
    assert(!operation.isExecuting)
    
    // Execute operation.
    operation.start()
    
    // Test final state.
    assert(operation.isFinished)
    assert(!operation.isExecuting)
    assert(operationDidExecute)
  }
  
  func testCancel() {
    
    // Test initial state.
    assert(!operation.isFinished)
    assert(!operation.isExecuting)
    
    // Execute operation.
    operation.cancel()
    operation.start()
    
    // Test final state.
    assert(operation.isFinished)
    assert(!operationDidExecute)
  }
}
