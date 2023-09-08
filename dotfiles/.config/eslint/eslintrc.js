module.exports = {
  'env': {
    'browser': true,
    'commonjs': true,
    'es6': true
  },
  'extends': [
    'eslint:recommended',
    'plugin:react/recommended'
  ],
  'parser': '@babel/eslint-parser',
  'parserOptions': {
    'ecmaFeatures': {
      'jsx': true
    },
    'ecmaVersion': 6,
    'requireConfigFile': false,
    'sourceType': 'module',
  },
  'root': true,
  'rules': {
    'indent': ['error', 2, {'SwitchCase': 1}],
    'linebreak-style': ['error', 'unix'],
    'quotes': ['error', 'single'],
    'react/prop-types': 0,
    'semi': ['error', 'always']
  }
};
