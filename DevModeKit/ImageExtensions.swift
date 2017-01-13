import Foundation
import UIKit

public typealias ImageCancelHandle = () -> ()

/// Loads and caches an image from a remote URL.
class ImageLoader {
  
  private let id = "com.devmode.DevModeKit"
  private let loadingQueue: OperationQueue
  
  private var imageCacheDir: String
  
  static let shared = ImageLoader()
  
  init() {
    imageCacheDir = NSTemporaryDirectory()
    if let groupDirectory = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: id) {
      let cacheDir = groupDirectory.appendingPathComponent("image-cache")
      let fileManager = FileManager.default
      do {
        try fileManager.createDirectory(at: cacheDir, withIntermediateDirectories: true, attributes: nil)
        imageCacheDir = cacheDir.path
      } catch {
        // Ignore for now
      }
    } else {
      imageCacheDir = NSTemporaryDirectory()
    }
    loadingQueue = OperationQueue()
    loadingQueue.maxConcurrentOperationCount = 2
  }
  
  func load(_ url: String, token: String?, callback: @escaping (UIImage) -> ()) -> ImageCancelHandle {
    var cancelled = false
    var cancelCallback = { cancelled = true }
    
    // Check for Valid URL:
    guard let url = URL(string: url) else { return cancelCallback }
    let key = self.keyForUrl(url)
    let fileManager = FileManager.default
    let cachePath = (self.imageCacheDir as NSString).appendingPathComponent(key)
    
    loadingQueue.addOperation(
      AsynchronousOperation { done in
        guard !cancelled else { return done() }
        
        // Validate Data:
        if fileManager.fileExists(atPath: cachePath) {
          guard !cancelled else { return done() }
          guard let data = try? Data(contentsOf: URL(fileURLWithPath: cachePath)),
            let image = UIImage(data: data, scale: UIScreen.main.scale),
            let decoded = self.decodedImage(image) else {
              
              done()
              return
          }
          DispatchQueue.main.async {
            callback(decoded)
          }
          done()
        } else {
          let request = URLRequest(url: url)
          let config = URLSessionConfiguration.default
          if let token = token {
            config.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
          }
          let session = URLSession(configuration: config)
          let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard !cancelled else { return done() }
            guard let data = data, let image = UIImage(data: data, scale: UIScreen.main.scale) else {
              done()
              return
            }
            DispatchQueue.main.async {
              callback(image)
            }
            try? UIImagePNGRepresentation(image)?.write(to: URL(fileURLWithPath: cachePath), options: [.atomic])
            done()
            return
          })
          task.resume()
          cancelCallback = {
            cancelled = true
            task.cancel()
          }
        }
      }
    )
    return cancelCallback
  }
  
  func replaceInCache(_ url: String, data: Data) {
    guard let url = URL(string: url) else { return }
    let key = keyForUrl(url)
    let cachePath = (imageCacheDir as NSString).appendingPathComponent(key)
    try? data.write(to: URL(fileURLWithPath: cachePath), options: [.atomic])
  }
  
  private func keyForUrl(_ url: URL) -> String {
    return url.path.replacingOccurrences(of: "/", with: "_")
  }
  
  private func decodedImage(_ image: UIImage) -> UIImage? {
    return self.decodedImage(image, scale: image.scale)
  }
  
  private func decodedImage(_ image: UIImage, scale: CGFloat) -> UIImage? {
    guard let imgRef = image.cgImage else { return nil }
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    let context = CGContext(data: nil, width: imgRef.width, height: imgRef.height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
    if let context = context {
      let rect = CGRect(x: 0, y: 0, width: CGFloat(imgRef.width), height: CGFloat(imgRef.height))
      context.draw(imgRef, in: rect)
      guard let decompressedImageRef = context.makeImage() else { return nil }
      return UIImage(cgImage: decompressedImageRef, scale: scale, orientation: image.imageOrientation)
    } else {
      return nil
    }
  }
}

public extension UIImage {
  
  /// Loads and caches an image from a remote URL.
  /// - parameter url: A remote URL to an image file.
  /// - parameter callback: A completion callback containing the image.
  /// - returns: A cancellation callback.
  public class func load(_ url: String, token: String? = nil, callback: @escaping (UIImage) -> ()) -> ImageCancelHandle {
    return ImageLoader.shared.load(url, token: token, callback: callback)
  }
}
