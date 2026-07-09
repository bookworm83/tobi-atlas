// See the shakacode/shakapacker README and docs directory for advice on customizing your rspackConfig.
const { generateRspackConfig } = require('shakapacker/rspack')
const { config } = require('shakapacker')

const rspackConfig = generateRspackConfig()

// Add server bundle configuration when SERVER_BUNDLE_ONLY is set
if (process.env.SERVER_BUNDLE_ONLY === 'true') {
  const serverBundleEntry = rspackConfig.entry?.['server-bundle']
  if (serverBundleEntry) {
    // Keep only server bundle entry
    rspackConfig.entry = {
      'server-bundle': serverBundleEntry,
    }
    
    // Set output path to ssr-generated directory
    const serverBundleOutputPath = config.privateOutputPath ||
      require('path').resolve(__dirname, '../../ssr-generated')
    
    rspackConfig.output = {
      path: serverBundleOutputPath,
      filename: 'server-bundle.js',
      globalObject: 'this',
    }
    
    // Disable optimization for SSR bundle
    rspackConfig.optimization = {
      minimize: false,
      splitChunks: false,
      moduleIds: 'named',
    }
    
    // Disable source maps for server bundle
    rspackConfig.devtool = false
    
    // Remove asset processing plugins that may cause conflicts
    rspackConfig.plugins = rspackConfig.plugins.filter(plugin => {
      const pluginName = plugin?.constructor?.name || ''
      return !(
        pluginName.includes('WebpackAssetsManifest') ||
        pluginName.includes('MiniCssExtractPlugin') ||
        pluginName.includes('ForkTsCheckerWebpackPlugin') ||
        pluginName.includes('SourceMapDevToolPlugin')
      )
    })
  }
}

module.exports = rspackConfig
