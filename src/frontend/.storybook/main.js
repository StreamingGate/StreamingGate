const path = require('path');

module.exports = {
  stories: ['../src/**/*.stories.mdx', '../src/**/*.stories.@(js|jsx)'],
  addons: ['@storybook/addon-essentials', '@storybook/addon-a11y'],
  framework: '@storybook/react',
  // staticDir: ['../src/assets/**'],
  core: {
    builder: 'webpack5',
  },
  webpackFinal: async (config, { configType }) => {
    config.resolve.alias['@'] = path.resolve(__dirname, '../src');
    config.resolve.alias['@assets'] = path.resolve(__dirname, '../src/assets');
    config.resolve.alias['@components'] = path.resolve(__dirname, '../src/components');
    config.resolve.alias['@pages'] = path.resolve(__dirname, '../src/pages');
    config.resolve.alias['@services'] = path.resolve(__dirname, '../src/services');
    config.resolve.alias['@utils'] = path.resolve(__dirname, '../src/utils');

    const webpackRules = config.module.rules;
    const fileLoader = webpackRules.find(rule => rule.test.test('.svg'));
    fileLoader.exclude = /\.svg$/i;

    webpackRules.push({
      test: /\.svg$/i,
      use: ['@svgr/webpack'],
    });

    return config;
  },
};