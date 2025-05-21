package com.margelo.nitro.realfetch

import com.margelo.nitro.core.ArrayBuffer
import com.margelo.nitro.core.Promise
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import java.io.InputStream

class HybridInputStream(
  val stream: InputStream,
  private val onClose: (() -> Unit)? = null
) : HybridInputStreamSpec() {
  companion object {
    private const val BUFFER_SIZE = 64 * 1024
  }

  override fun read(): Promise<ArrayBuffer> {
    return Promise.async(CoroutineScope(Dispatchers.IO)) {
      val bytes = ByteArray(BUFFER_SIZE)
      val bytesRead = stream.read(bytes, 0, bytes.size)

      when {
        bytesRead == -1 -> {
          val emptyBuffer = ArrayBuffer.allocate(0)
          emptyBuffer
        }
        bytesRead > 0 -> {
          val arrayBuffer = ArrayBuffer.allocate(bytesRead)
          val destBuffer = arrayBuffer.getBuffer(false)
          destBuffer.put(bytes, 0, bytesRead)
          arrayBuffer
        }
        else -> {
            throw Error("Unexpected error reading stream")
        }
      }
    }
  }

  override fun open() {
  }

  override fun close() {
    try {
      stream.close()
    }
    finally {
      onClose?.invoke()
    }
  }

  override val memorySize: Long
    get() = try {
      stream.available().toLong()
    } catch (e: Exception) {
      0L
    }
}
