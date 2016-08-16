module.exports = {
  entry: './public/javascripts/index.js',

  output: {
    filename: './public/javascripts/bundle.js',
    publicPath: ''
  },

  module: {
    loaders: [
      { test: /\.js$/, exclude: /node_modules/, loader: 'babel-loader?presets[]=es2015&presets[]=react' }
    ]
  }
}
