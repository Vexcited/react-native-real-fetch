package com.margelo.nitro.realfetch

import com.margelo.nitro.core.Promise
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import java.net.HttpURLConnection
import java.net.URL

class HybridFetch : HybridFetchSpec() {
  companion object {
    // We're skipping these headers, not sure if those
    // would be useful to anyone...
    private val EXCLUDED_HEADERS = setOf(
      "X-Android-Sent-Millis",
      "X-Android-Received-Millis",
      "X-Android-Response-Source",
      "X-Android-Selected-Protocol",
      "X-Android-Selected-Transport"
    )

    private const val BUFFER_SIZE = 64 * 1024
  }

  override fun create(opts: NativeRequest): Promise<NativeResponse> {
    return Promise.async(CoroutineScope(Dispatchers.IO)) {
      val connection = URL(opts.url).openConnection() as HttpURLConnection

      connection.requestMethod = opts.method.name.uppercase()
      connection.doOutput = opts.body != null
      connection.doInput = true

      // Disable cache.
      connection.useCaches = false
      connection.defaultUseCaches = false
      // NOTE: not sure if those headers are somewhat useful ?
      // connection.setRequestProperty("Cache-Control", "no-cache, no-store, must-revalidate")
      // connection.setRequestProperty("Pragma", "no-cache")

      when (opts.redirection) {
        RequestRedirection.FOLLOW -> connection.instanceFollowRedirects = true
        RequestRedirection.MANUAL -> connection.instanceFollowRedirects = false
      }

      for (i in 0 until opts.headers.size step 2) {
        if (i + 1 < opts.headers.size) {
          val key = opts.headers[i]
          val value = opts.headers[i + 1]
          connection.setRequestProperty(key, value)
        }
      }

      opts.body?.let { hybridStream ->
        (hybridStream as HybridInputStream).stream.use { input ->
          connection.outputStream.buffered().use { output ->
            input.copyTo(output, BUFFER_SIZE)
          }
        }
      }

      val statusCode = connection.responseCode.toDouble()
      val statusText = connection.responseMessage

      val responseHeaders: Array<String> = connection.headerFields
        .filterKeys { it != null }
        .filterKeys { key -> key !in EXCLUDED_HEADERS }
        .flatMap { (key, values) ->
          values.flatMap { value -> listOf(key!!, value) }
        }
        .toTypedArray()

      val responseBody = HybridInputStream(connection.inputStream) {
        connection.disconnect()
      }

      val responseUrl = connection.url.toString()
      val redirected = opts.url != responseUrl

      NativeResponse(responseUrl, statusCode, statusText, responseHeaders, responseBody, redirected)
    }
  }

  override val memorySize: Long
    get() = 0L
}
