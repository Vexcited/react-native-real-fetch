import { NitroModules, type HybridObject } from 'react-native-nitro-modules'

export type RequestMethods = 'GET' | 'HEAD' | 'POST' | 'PUT' | 'DELETE' | 'CONNECT' | 'OPTIONS' | 'TRACE' | 'PATCH';
export type RequestRedirection = 'follow' | 'manual'

export interface NativeRequest {
  url: string
  method: RequestMethods
  redirection: RequestRedirection
  /**
   * @example
   * // the following...
   * const headers = { hello: "world" };
   * // becomes...
   * const headers = ["hello", "world"];
   */
  headers: Array<string>
}

export interface NativeResponse {
  status: number
  headers: Array<string>
}

interface Fetch extends HybridObject<{ ios: 'swift'; android: 'kotlin' }> {
  create(opts: NativeRequest): Promise<NativeResponse>
}

export const Fetch = NitroModules.createHybridObject<Fetch>("Fetch");
