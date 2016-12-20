import Foundation

public func onMain(callback:@escaping ()->()){
    DispatchQueue.main.async(execute: callback)
}
