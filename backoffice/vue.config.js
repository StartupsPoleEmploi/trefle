module.exports = {
    publicPath: "/0.7/explorer/",
    assetsDir: "src/assets/",
    devServer: {
        proxy: 'http://127.0.0.1:3579'
    }
}
