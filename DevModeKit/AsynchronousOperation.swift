import Foundation


/// A task to be run with a callback to indicate completion
public typealias AsyncTask = (@escaping ()->()) -> ()

/// A task to be run with a callback to indicate completion with access to the invoking operation.
public typealias AsyncOperationTask = (AsynchronousOperation, @escaping ()->()) -> Void

/// Invoke a list of async operations with a specified level of concurrency and call the provided callback when all complete.
public func asyncInvokeAll(queue: OperationQueue? = nil, concurrency: Int = 4, tasks: [AsyncOperationTask], completion: @escaping ()->()) {
  let queue = queue ?? OperationQueue()
  queue.maxConcurrentOperationCount  = concurrency
  let finishOp = BlockOperation(block: completion)
  for task in tasks {
    let taskOp = AsynchronousOperation(task: task)
    finishOp.addDependency(taskOp)
    queue.addOperation(taskOp)
  }
  queue.addOperation(finishOp)
}

/// Invoke a list of async operations in order and call the provided callback when all complete.
public func asyncInvokeSerial(queue: OperationQueue? = nil, tasks: [AsyncOperationTask], completion: @escaping ()->()) {
  asyncInvokeAll(queue: queue, concurrency: 1, tasks: tasks, completion: completion)
}

/// A sub-class of "Operation" with additional functionality
/// specific to asynchronous operations.
open class AsynchronousOperation : Operation {
  
  let task: AsyncOperationTask

  private var _finished = false
  private var _executing = false
  private var _cancelled = false
  
  /// Indicates whether the operation is concurrent.
  open override var isConcurrent : Bool {
    get { return true }
  }
    
  /// Indicates whether the operation is finished.
  open override var isFinished : Bool {
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
  open override var isExecuting : Bool {
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
  
  /// Initializes an asynchronous operation with a specified task.
  /// - parameter task: A task to be executed asynchronously.  
  public init(task: @escaping AsyncOperationTask) {
    self.task = task
  }
  
  /// Start the asynchronous operation.
  open override func start() {
    if self.isCancelled {
      self.isFinished = true
      self.isExecuting = true
      return
    }
    self.isExecuting = true
    self.isFinished = false
    self.task(self) {
      self.isExecuting = false
      self.isFinished = true
    }
  }
  
  /// Cancel the asynchronous operation.
  open override func cancel() {
    self.isCancelled = true
  }
}