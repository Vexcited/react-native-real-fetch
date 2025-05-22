import Foundation
import NitroModules

class HybridFetch: HybridFetchSpec {
  func create(opts: NativeRequest) throws -> Promise<NativeResponse> {
    guard let requestUrl = URL(string: opts.url) else {
      return Promise.rejected(withError: NSError(domain: "Invalid URL: \(opts.url)", code: -1))
    }

    var request = URLRequest(url: requestUrl)
    request.httpMethod = opts.method.stringValue

    if let inputStream = opts.body as? HybridInputStream {
      request.httpBodyStream = inputStream.stream
    }

    for i in stride(from: 0, to: opts.headers.count, by: 2) {
      if i + 1 < opts.headers.count {
        let key = opts.headers[i]
        let value = opts.headers[i + 1]
        request.setValue(value, forHTTPHeaderField: key)
      }
    }

    let promise = Promise<NativeResponse>()

    Task {
      do {
        let (byteStream, response): (URLSession.AsyncBytes, URLResponse)

        let configuration = URLSessionConfiguration.default

        // Disable cache.
        // NOTE: there's probably a `fetch` property for this ?
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.urlCache = nil

        // Disable internal cookie jar.
        configuration.httpCookieAcceptPolicy = .never
        configuration.httpShouldSetCookies = false
        configuration.httpCookieStorage = nil

        if opts.redirection == .manual {
          let delegate = NoRedirectDelegate()
          let session = URLSession(
            configuration: configuration, delegate: delegate, delegateQueue: nil)
          (byteStream, response) = try await session.bytes(for: request)
        } else {
          let session = URLSession(configuration: configuration)
          (byteStream, response) = try await session.bytes(for: request)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
          throw NSError(domain: "Invalid HTTP response", code: -2)
        }

        let stream = AsyncBytesInputStream(bytes: byteStream)

        let statusCode = Double(httpResponse.statusCode)
        let statusText = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)

        var responseHeaders: [String] = []

        for (key, value) in httpResponse.allHeaderFields {
          if let headerKey = key as? String, let headerValue = value as? String {
            responseHeaders.append(headerKey)
            responseHeaders.append(headerValue)
          }
        }

        let responseUrl = httpResponse.url?.absoluteString ?? opts.url
        let redirected = normalizeUrl(opts.url) != normalizeUrl(responseUrl)

        let outputStream = HybridInputStream(stream: stream)

        let responseObject = NativeResponse(
          url: responseUrl,
          status: statusCode,
          statusText: statusText,
          headers: responseHeaders,
          body: outputStream,
          redirected: redirected
        )

        promise.resolve(withResult: responseObject)
      } catch {
        promise.reject(withError: error)
      }
    }

    return promise
  }

  private func normalizeUrl(_ urlString: String) -> String {
    guard let url = URL(string: urlString) else { return urlString }

    // Create a normalized URL components
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)

    if components?.path.isEmpty == true {
      components?.path = "/"
    }

    return components?.url?.absoluteString ?? urlString
  }
}
