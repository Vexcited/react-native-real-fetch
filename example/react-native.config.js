const path = require('path')
const pkg = require('../package/package.json')

module.exports = {
  project: {
    ios: {
      automaticPodsInstallation: true,
    },
  },
  dependencies: {
    [pkg.name]: {
      root: path.join(__dirname, '..', 'package'),
    },
  },
}
