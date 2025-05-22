# react-native-real-fetch

A not-so-perfect [Fetch API](https://developer.mozilla.org/docs/Web/API/Fetch_API) implementation that’s good enough to do what React Native’s `fetch` can’t.

## What does this do better ?

- No weird `Cookie` header behavior — it does not store previous `Set-Cookie` headers in an internal cookie jar. You have to manage them yourself.
- `redirect: "manual"` finally prevents any redirection from happening.

## Limitations

On both **Android and iOS**, the `statusText` property depends on the OS' implementation. It will not retrieve the status text from the server.

Basically, whatever you can do with [`fetch`](https://developer.mozilla.org/docs/Web/API/Window/fetch) should be possible here —
just check the types to ensure the variables you're passing are supported.

Since I initially developed this for personal use, only basic functionality is supported.
If you need advanced features like signal for aborting requests, they likely aren’t supported.

Please [open an issue](https://github.com/Vexcited/react-native-real-fetch/issues) if there's something essential you need that isn’t supported.

## Installation

#### React Native

```sh
npm add react-native-real-fetch react-native-nitro-modules
cd ios && pod install
```

#### Expo

```sh
npx expo add react-native-real-fetch react-native-nitro-modules
npx expo prebuild
```

## Usages

```typescript
import { fetch } from "react-native-real-fetch";

const response = await fetch("https://api.github.com");
const json = await response.json();
```

```typescript
import { fetch } from "react-native-real-fetch";

const { status, headers } = await fetch("http://api.local.dev/api/login", {
  method: "POST",
  redirect: "manual",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ username, password })
});

if (status === 200) {
  const cookies = headers.get("set-cookie");
  console.log(cookies);
}
```

```typescript
import { fetch } from "react-native-real-fetch";

const response = await fetch("http://api.local.dev/api/user", {
  headers: { "Cookie": "session=some_token; lang=en" }
  // Only the given cookies will be sent, no stored additional cookies will be sent !
  // In fact, nothing is stored.
});

const bytes = await response.bytes();
console.log(bytes); // > Uint8Array
```

## Android configuration for using `http:`

Since Android 9 (API level 28), cleartext (`http:`) traffic is restricted by default. To allow it, you need to explicitly enable it.

### Allowing HTTP for All Domains

To enable HTTP for all domains, add the following to your `AndroidManifest.xml`.

```xml
<application
    android:usesCleartextTraffic="true"
    ... >
</application>
```

### Allowing HTTP for Specific Domains Only

If you prefer to allow HTTP traffic only for specific domains, use a `networkSecurityConfig` instead.

```xml
<application
  android:networkSecurityConfig="@xml/network_security_config"
  ... >
</application>
```

Then, create a `res/xml/network_security_config.xml` file to define the domain-specific configuration.

```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
  <domain-config cleartextTrafficPermitted="true">
    <domain includeSubdomains="true">yourdomain.com</domain>
  </domain-config>
</network-security-config>
```

## Contributing

```sh
git clone https://github.com/Vexcited/react-native-real-fetch
cd react-native-real-fetch/package
npm install
```

After making your changes, you can build the package with the following commands.

```sh
npm run clean
npm run codegen
npm run build
```

To see how to run the example app, head over to the [`example`](/example) folder.

## Credits

- [react-native-fast-io](https://github.com/callstackincubator/react-native-fast-io) – A lot of code was adapted from this project.
