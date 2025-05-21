package com.margelo.nitro.realfetch

import java.io.PipedInputStream
import java.io.PipedOutputStream

class HybridDuplexStream : HybridDuplexStreamSpec() {
  companion object {
    private const val BUFFER_SIZE = 64 * 1024
  }

  private val pipeIn = PipedInputStream(BUFFER_SIZE)
  private val pipeOut = PipedOutputStream(pipeIn)

  override var inputStream: HybridInputStreamSpec = HybridInputStream(pipeIn)
  override var outputStream: HybridOutputStreamSpec = HybridOutputStream(pipeOut)

  override val memorySize: Long = 0L

  fun close() {
    try {
      pipeOut.close()
      pipeIn.close()
    }
    catch (e: Exception) {
      System.err.println("Error closing duplex stream: ${e.message}")
    }
  }
}
