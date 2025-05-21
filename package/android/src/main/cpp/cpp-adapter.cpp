#include <jni.h>
#include "NitroRealFetchOnLoad.hpp"

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM* vm, void*) {
  return margelo::nitro::realfetch::initialize(vm);
}
