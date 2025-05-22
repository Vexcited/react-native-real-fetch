import Foundation

class HybridDuplexStream: HybridDuplexStreamSpec {
  private static let bufferSize = 64 * 1024

  var inputStream: (any HybridInputStreamSpec)
  var outputStream: (any HybridOutputStreamSpec)

  override init() {
    var inputStreamRef: InputStream? = InputStream()
    var outputStreamRef: OutputStream? = OutputStream(toMemory: ())

    Stream.getBoundStreams(
      withBufferSize: HybridDuplexStream.bufferSize,
      inputStream: &inputStreamRef,
      outputStream: &outputStreamRef)

    guard let inputStreamRef, let outputStreamRef else {
      fatalError("Could not create streams")
    }

    inputStream = HybridInputStream(stream: inputStreamRef)
    outputStream = HybridOutputStream(stream: outputStreamRef)
  }

  var memorySize: Int {
    return 0
  }
}
