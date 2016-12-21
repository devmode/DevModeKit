import Foundation

/// Used for image load caching.
open class DMAsyncOperation: Operation {
  
  let task: (@escaping () -> ()) -> ()
  
  open override var isAsynchronous : Bool {
    return true
  }
  
  fileprivate var _finished = false
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
  
  fileprivate var _executing = false
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
  
  fileprivate var _cancelled = false
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
  
  public init(task: @escaping (@escaping () -> ()) -> ()) {
    self.task = task
  }
  
  open override func start() {
    if self.isCancelled {
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
  
  open override func cancel() {
    super.cancel()
    self.isCancelled = true
  }
}
