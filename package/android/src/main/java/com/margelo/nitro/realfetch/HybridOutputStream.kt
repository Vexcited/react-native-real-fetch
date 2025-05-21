package com.margelo.nitro.realfetch

import com.margelo.nitro.core.ArrayBuffer
import com.margelo.nitro.core.Promise
import java.io.OutputStream

class HybridOutputStream(private val stream: OutputStream) : HybridOutputStreamSpec() {
  override fun write(buffer: ArrayBuffer): Promise<Unit> {
    val byteBuffer = buffer.getBuffer(false)
    val bytes = ByteArray(buffer.size)
    byteBuffer.get(bytes)

    return Promise.async {
      stream.write(bytes)
    }
  }

  override fun open() {
  }

  override fun close() {
    stream.flush()
    stream.close()
  }

  override val memorySize: Long
    get() = 0L
}
