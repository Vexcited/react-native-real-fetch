///
/// HybridOutputStreamSpec.cpp
/// This file was generated by nitrogen. DO NOT MODIFY THIS FILE.
/// https://github.com/mrousavy/nitro
/// Copyright © 2025 Marc Rousavy @ Margelo
///

#include "HybridOutputStreamSpec.hpp"

namespace margelo::nitro::realfetch {

  void HybridOutputStreamSpec::loadHybridMethods() {
    // load base methods/properties
    HybridObject::loadHybridMethods();
    // load custom methods/properties
    registerHybrids(this, [](Prototype& prototype) {
      prototype.registerHybridMethod("write", &HybridOutputStreamSpec::write);
      prototype.registerHybridMethod("open", &HybridOutputStreamSpec::open);
      prototype.registerHybridMethod("close", &HybridOutputStreamSpec::close);
    });
  }

} // namespace margelo::nitro::realfetch
