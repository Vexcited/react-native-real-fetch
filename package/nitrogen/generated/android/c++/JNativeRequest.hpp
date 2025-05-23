///
/// JNativeRequest.hpp
/// This file was generated by nitrogen. DO NOT MODIFY THIS FILE.
/// https://github.com/mrousavy/nitro
/// Copyright © 2025 Marc Rousavy @ Margelo
///

#pragma once

#include <fbjni/fbjni.h>
#include "NativeRequest.hpp"

#include "HybridInputStreamSpec.hpp"
#include "JHybridInputStreamSpec.hpp"
#include "JRequestMethods.hpp"
#include "JRequestRedirection.hpp"
#include "RequestMethods.hpp"
#include "RequestRedirection.hpp"
#include <NitroModules/JNISharedPtr.hpp>
#include <memory>
#include <optional>
#include <string>
#include <vector>

namespace margelo::nitro::realfetch {

  using namespace facebook;

  /**
   * The C++ JNI bridge between the C++ struct "NativeRequest" and the the Kotlin data class "NativeRequest".
   */
  struct JNativeRequest final: public jni::JavaClass<JNativeRequest> {
  public:
    static auto constexpr kJavaDescriptor = "Lcom/margelo/nitro/realfetch/NativeRequest;";

  public:
    /**
     * Convert this Java/Kotlin-based struct to the C++ struct NativeRequest by copying all values to C++.
     */
    [[maybe_unused]]
    [[nodiscard]]
    NativeRequest toCpp() const {
      static const auto clazz = javaClassStatic();
      static const auto fieldUrl = clazz->getField<jni::JString>("url");
      jni::local_ref<jni::JString> url = this->getFieldValue(fieldUrl);
      static const auto fieldMethod = clazz->getField<JRequestMethods>("method");
      jni::local_ref<JRequestMethods> method = this->getFieldValue(fieldMethod);
      static const auto fieldRedirection = clazz->getField<JRequestRedirection>("redirection");
      jni::local_ref<JRequestRedirection> redirection = this->getFieldValue(fieldRedirection);
      static const auto fieldHeaders = clazz->getField<jni::JArrayClass<jni::JString>>("headers");
      jni::local_ref<jni::JArrayClass<jni::JString>> headers = this->getFieldValue(fieldHeaders);
      static const auto fieldBody = clazz->getField<JHybridInputStreamSpec::javaobject>("body");
      jni::local_ref<JHybridInputStreamSpec::javaobject> body = this->getFieldValue(fieldBody);
      return NativeRequest(
        url->toStdString(),
        method->toCpp(),
        redirection->toCpp(),
        [&]() {
          size_t __size = headers->size();
          std::vector<std::string> __vector;
          __vector.reserve(__size);
          for (size_t __i = 0; __i < __size; __i++) {
            auto __element = headers->getElement(__i);
            __vector.push_back(__element->toStdString());
          }
          return __vector;
        }(),
        body != nullptr ? std::make_optional(JNISharedPtr::make_shared_from_jni<JHybridInputStreamSpec>(jni::make_global(body))) : std::nullopt
      );
    }

  public:
    /**
     * Create a Java/Kotlin-based struct by copying all values from the given C++ struct to Java.
     */
    [[maybe_unused]]
    static jni::local_ref<JNativeRequest::javaobject> fromCpp(const NativeRequest& value) {
      return newInstance(
        jni::make_jstring(value.url),
        JRequestMethods::fromCpp(value.method),
        JRequestRedirection::fromCpp(value.redirection),
        [&]() {
          size_t __size = value.headers.size();
          jni::local_ref<jni::JArrayClass<jni::JString>> __array = jni::JArrayClass<jni::JString>::newArray(__size);
          for (size_t __i = 0; __i < __size; __i++) {
            const auto& __element = value.headers[__i];
            __array->setElement(__i, *jni::make_jstring(__element));
          }
          return __array;
        }(),
        value.body.has_value() ? std::dynamic_pointer_cast<JHybridInputStreamSpec>(value.body.value())->getJavaPart() : nullptr
      );
    }
  };

} // namespace margelo::nitro::realfetch
