import "@bacons/text-decoder/install";
import { type RequestMethods, type RequestRedirection, Fetch, type NativeResponse } from "./specs/fetch.nitro";
export * from "./specs/fetch.nitro";

export interface RequestInit {
  // TODO: as of today, only `string` is supported.
  // body?: string // | ArrayBuffer | Blob | DataView | File | FormData | URLSearchParams

  /**
   * Any headers you want to add to your request, contained within an object literal
   * whose keys are the names of headers and whose values are the header values.
   */
  headers?: Record<string, string>

  method?: RequestMethods

  /**
   * Determines RN's behavior in case the server replies with a redirect status (`300..399`).
   * @default 'follow'
   */
  redirect?: RequestRedirection
}

export class Request {
  readonly url: string;
  readonly method: RequestMethods;

  /**
   * Determines RN's behavior in case the server replies with a redirect status (`300..399`).
   * @default 'follow'
   */
  readonly redirect: RequestRedirection

  /**
   * Any headers you want to add to your request, contained within an object literal
   * whose keys are the names of headers and whose values are the header values.
   */
  readonly headers: Record<string, string>

  constructor(input: string | URL, init?: RequestInit) {
    if (typeof input !== 'string') {
      input = input.href;
    }

    this.method = init?.method ?? "GET";
    this.url = input;
    this.redirect = init?.redirect ?? "follow";
    this.headers = init?.headers ?? {};
  }
}

export async function fetch (
  input: string | URL,
  init?: RequestInit
): Promise<NativeResponse> {
  const request = new Request(input, init);

  const response = await Fetch.create({
    url: request.url,
    method: request.method,
    redirection: request.redirect,
    headers: Object.entries(request.headers).flat()
  });

  return response;
}
