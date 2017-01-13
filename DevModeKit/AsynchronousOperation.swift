import Foundation

/// A sub-class of "Operation" with additional functionality
/// specific to asynchronous operations.
open class AsynchronousOperation: Operation {
  
  private let task: (@escaping () -> ()) -> ()
  
  private var _finished = false
  private var _executing = false
  private var _cancelled = false
  
  /// Indicates whether the operation is finished.
  open override var isFinished: Bool {
    get {
      return _finished
    }
    set {
      willChangeValue(forKey: "isFinished")
      _finished = newValue
      didChangeValue(forKey: "isFinished")
    }
  }
  
  /// Indicates whether the operation is currently executing or not.
  open override var isExecuting: Bool {
    get {
      return _executing
    }
    set {
      willChangeValue(forKey: "isExecuting")
      _executing = newValue
      didChangeValue(forKey: "isExecuting")
    }
  }
  
  /// Indicates whether the operation has been cancelled or not.
  open override var isCancelled : Bool {
    get {
      return _cancelled
    }
    set {
      willChangeValue(forKey: "isCancelled")
      _cancelled = newValue
      didChangeValue(forKey: "isCancelled")
    }
  }
  
  /// Indicates whether the operation is asynchronous.
  open override var isAsynchronous: Bool {
    return true
  }
  
  /// Initializes an asynchronous operation with a specified task.
  /// - parameter task: A task to be executed asynchronously.
  public init(task: @escaping (@escaping () -> ()) -> ()) {
    self.task = task
  }
  
  /// Start the asynchronous operation.
  open override func start() {
    guard !self.isCancelled else {
      self.isFinished = true
      self.isExecuting = false
      return
    }
    self.isExecuting = true
    self.isFinished = false
    self.task() { [weak self] in
      self?.isExecuting = false
      self?.isFinished = true
    }
  }
  
  /// Cancel the asynchronous operation.
  open override func cancel() {
    super.cancel()
    self.isCancelled = true
  }
}
