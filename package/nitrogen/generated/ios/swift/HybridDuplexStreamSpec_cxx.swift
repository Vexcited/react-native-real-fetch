///
/// HybridDuplexStreamSpec_cxx.swift
/// This file was generated by nitrogen. DO NOT MODIFY THIS FILE.
/// https://github.com/mrousavy/nitro
/// Copyright © 2025 Marc Rousavy @ Margelo
///

import Foundation
import NitroModules

/**
 * A class implementation that bridges HybridDuplexStreamSpec over to C++.
 * In C++, we cannot use Swift protocols - so we need to wrap it in a class to make it strongly defined.
 *
 * Also, some Swift types need to be bridged with special handling:
 * - Enums need to be wrapped in Structs, otherwise they cannot be accessed bi-directionally (Swift bug: https://github.com/swiftlang/swift/issues/75330)
 * - Other HybridObjects need to be wrapped/unwrapped from the Swift TCxx wrapper
 * - Throwing methods need to be wrapped with a Result<T, Error> type, as exceptions cannot be propagated to C++
 */
public class HybridDuplexStreamSpec_cxx {
  /**
   * The Swift <> C++ bridge's namespace (`margelo::nitro::realfetch::bridge::swift`)
   * from `NitroRealFetch-Swift-Cxx-Bridge.hpp`.
   * This contains specialized C++ templates, and C++ helper functions that can be accessed from Swift.
   */
  public typealias bridge = margelo.nitro.realfetch.bridge.swift

  /**
   * Holds an instance of the `HybridDuplexStreamSpec` Swift protocol.
   */
  private var __implementation: any HybridDuplexStreamSpec

  /**
   * Holds a weak pointer to the C++ class that wraps the Swift class.
   */
  private var __cxxPart: bridge.std__weak_ptr_margelo__nitro__realfetch__HybridDuplexStreamSpec_

  /**
   * Create a new `HybridDuplexStreamSpec_cxx` that wraps the given `HybridDuplexStreamSpec`.
   * All properties and methods bridge to C++ types.
   */
  public init(_ implementation: any HybridDuplexStreamSpec) {
    self.__implementation = implementation
    self.__cxxPart = .init()
    /* no base class */
  }

  /**
   * Get the actual `HybridDuplexStreamSpec` instance this class wraps.
   */
  @inline(__always)
  public func getHybridDuplexStreamSpec() -> any HybridDuplexStreamSpec {
    return __implementation
  }

  /**
   * Casts this instance to a retained unsafe raw pointer.
   * This acquires one additional strong reference on the object!
   */
  public func toUnsafe() -> UnsafeMutableRawPointer {
    return Unmanaged.passRetained(self).toOpaque()
  }

  /**
   * Casts an unsafe pointer to a `HybridDuplexStreamSpec_cxx`.
   * The pointer has to be a retained opaque `Unmanaged<HybridDuplexStreamSpec_cxx>`.
   * This removes one strong reference from the object!
   */
  public class func fromUnsafe(_ pointer: UnsafeMutableRawPointer) -> HybridDuplexStreamSpec_cxx {
    return Unmanaged<HybridDuplexStreamSpec_cxx>.fromOpaque(pointer).takeRetainedValue()
  }

  /**
   * Gets (or creates) the C++ part of this Hybrid Object.
   * The C++ part is a `std::shared_ptr<margelo::nitro::realfetch::HybridDuplexStreamSpec>`.
   */
  public func getCxxPart() -> bridge.std__shared_ptr_margelo__nitro__realfetch__HybridDuplexStreamSpec_ {
    let cachedCxxPart = self.__cxxPart.lock()
    if cachedCxxPart.__convertToBool() {
      return cachedCxxPart
    } else {
      let newCxxPart = bridge.create_std__shared_ptr_margelo__nitro__realfetch__HybridDuplexStreamSpec_(self.toUnsafe())
      __cxxPart = bridge.weakify_std__shared_ptr_margelo__nitro__realfetch__HybridDuplexStreamSpec_(newCxxPart)
      return newCxxPart
    }
  }

  

  /**
   * Get the memory size of the Swift class (plus size of any other allocations)
   * so the JS VM can properly track it and garbage-collect the JS object if needed.
   */
  @inline(__always)
  public var memorySize: Int {
    return MemoryHelper.getSizeOf(self.__implementation) + self.__implementation.memorySize
  }

  // Properties
  public final var inputStream: bridge.std__shared_ptr_margelo__nitro__realfetch__HybridInputStreamSpec_ {
    @inline(__always)
    get {
      return { () -> bridge.std__shared_ptr_margelo__nitro__realfetch__HybridInputStreamSpec_ in
        let __cxxWrapped = self.__implementation.inputStream.getCxxWrapper()
        return __cxxWrapped.getCxxPart()
      }()
    }
    @inline(__always)
    set {
      self.__implementation.inputStream = { () -> HybridInputStreamSpec in
        let __unsafePointer = bridge.get_std__shared_ptr_margelo__nitro__realfetch__HybridInputStreamSpec_(newValue)
        let __instance = HybridInputStreamSpec_cxx.fromUnsafe(__unsafePointer)
        return __instance.getHybridInputStreamSpec()
      }()
    }
  }
  
  public final var outputStream: bridge.std__shared_ptr_margelo__nitro__realfetch__HybridOutputStreamSpec_ {
    @inline(__always)
    get {
      return { () -> bridge.std__shared_ptr_margelo__nitro__realfetch__HybridOutputStreamSpec_ in
        let __cxxWrapped = self.__implementation.outputStream.getCxxWrapper()
        return __cxxWrapped.getCxxPart()
      }()
    }
    @inline(__always)
    set {
      self.__implementation.outputStream = { () -> HybridOutputStreamSpec in
        let __unsafePointer = bridge.get_std__shared_ptr_margelo__nitro__realfetch__HybridOutputStreamSpec_(newValue)
        let __instance = HybridOutputStreamSpec_cxx.fromUnsafe(__unsafePointer)
        return __instance.getHybridOutputStreamSpec()
      }()
    }
  }

  // Methods
  
}
