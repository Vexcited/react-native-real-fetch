///
/// HybridOutputStreamSpec.swift
/// This file was generated by nitrogen. DO NOT MODIFY THIS FILE.
/// https://github.com/mrousavy/nitro
/// Copyright © 2025 Marc Rousavy @ Margelo
///

import Foundation
import NitroModules

/// See ``HybridOutputStreamSpec``
public protocol HybridOutputStreamSpec_protocol: HybridObject {
  // Properties
  

  // Methods
  func write(buffer: ArrayBufferHolder) throws -> Promise<Void>
  func open() throws -> Void
  func close() throws -> Void
}

/// See ``HybridOutputStreamSpec``
public class HybridOutputStreamSpec_base {
  private weak var cxxWrapper: HybridOutputStreamSpec_cxx? = nil
  public func getCxxWrapper() -> HybridOutputStreamSpec_cxx {
  #if DEBUG
    guard self is HybridOutputStreamSpec else {
      fatalError("`self` is not a `HybridOutputStreamSpec`! Did you accidentally inherit from `HybridOutputStreamSpec_base` instead of `HybridOutputStreamSpec`?")
    }
  #endif
    if let cxxWrapper = self.cxxWrapper {
      return cxxWrapper
    } else {
      let cxxWrapper = HybridOutputStreamSpec_cxx(self as! HybridOutputStreamSpec)
      self.cxxWrapper = cxxWrapper
      return cxxWrapper
    }
  }
}

/**
 * A Swift base-protocol representing the OutputStream HybridObject.
 * Implement this protocol to create Swift-based instances of OutputStream.
 * ```swift
 * class HybridOutputStream : HybridOutputStreamSpec {
 *   // ...
 * }
 * ```
 */
public typealias HybridOutputStreamSpec = HybridOutputStreamSpec_protocol & HybridOutputStreamSpec_base
