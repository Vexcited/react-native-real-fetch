import Foundation
import NitroModules

class HybridInputStream: HybridInputStreamSpec {
  let stream: InputStream

  init(stream: InputStream) {
    self.stream = stream
  }

  func open() throws {
    stream.open()
  }

  func read() throws -> Promise<ArrayBuffer> {
    let promise = Promise<ArrayBuffer>()

    Task {
      let size = Int(64 * 1024)
      let data = UnsafeMutablePointer<UInt8>.allocate(capacity: size)

      let bytesRead = stream.read(data, maxLength: size)

      let deleteFunc = {
        data.deallocate()
      }

      if bytesRead >= 0 {
        promise.resolve(
          withResult: ArrayBuffer.wrap(
            dataWithoutCopy: data, size: bytesRead, onDelete: deleteFunc))
      } else {
        deleteFunc()
        promise.reject(
          withError: stream.streamError
            ?? RuntimeError.error(withMessage: "Unexpected error reading stream"))
      }
    }

    return promise
  }

  func close() {
    stream.close()
  }
}
