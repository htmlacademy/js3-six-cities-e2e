const { defineConfig } = require('cypress');

module.exports = defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      return require('./cypress/plugins/index.js')(on, config);
    },
    excludeSpecPattern: '*.js',
    specPattern: 'cypress/integration/**/*.{feature,features}',
    baseUrl: 'http://localhost:5173',
    baseApiUrl: 'https://14.design.pages.academy/six-cities',
    viewportHeight: 1000,
    viewportWidth: 1280,
    experimentalWebKitSupport: true,
  },
});
