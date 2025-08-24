const { getDefaultConfig, mergeConfig } = require("@react-native/metro-config");

const path = require("path");
const root = path.resolve(__dirname, "..", "..");

/**
 * Metro configuration
 * https://reactnative.dev/docs/metro
 *
 * @type {import('@react-native/metro-config').MetroConfig}
 */
const config = {
  watchFolders: [root],
  resolver: {
    unstable_enablePackageExports: true,
  },
};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);
