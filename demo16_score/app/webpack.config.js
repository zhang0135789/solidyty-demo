const path = require('path')
const CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports = {
  entry: './src/javascripts/app.js',
  output: {
    path: path.resolve(__dirname, 'build'),
    filename: 'app.js'
  },
  plugins: [
    // Copy our app's index.html to the build folder.
    new CopyWebpackPlugin([
      { from: './src/index.html', to: 'index.html' }
    ]),
    new CopyWebpackPlugin([
      { from: './src/customer.html', to: 'customer.html' }
    ]),
    new CopyWebpackPlugin([
      { from: './src/bank.html', to: 'bank.html' }
    ]),
    new CopyWebpackPlugin([
      { from: './src/merchant.html', to: 'merchant.html' }
    ])
  ],
  module: {
    rules: [
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader']
      }
    ],
    loaders: [
      { test: /\.json$/, use: 'json-loader' },
      {
        test: /\.js$/,
        exclude: /(node_modules|bower_components)/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015'],
          plugins: ['transform-runtime']
        }
      }
    ]
  }
}
