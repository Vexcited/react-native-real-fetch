import Foundation
import NitroModules

class HybridOutputStream: HybridOutputStreamSpec {
  let stream: OutputStream

  init(stream: OutputStream) {
    self.stream = stream
  }

  func open() throws {
    stream.open()
  }

  func write(buffer: ArrayBuffer) throws -> Promise<Void> {
    let promise = Promise<Void>()

    let data = buffer.data
    let length = buffer.size

    Task {
      let bytesWritten = stream.write(data, maxLength: length)
      if bytesWritten == length {
        promise.resolve(withResult: ())
      } else {
        promise.reject(
          withError: stream.streamError
            ?? RuntimeError.error(withMessage: "Unexpected error writing to stream"))
      }
    }

    return promise
  }

  func close() {
    stream.close()
  }

  var memorySize: Int {
    return 0
  }
}
