module.exports = {
    publicPath: "/0.8/explorer/",
    assetsDir: "src/assets/",
    devServer: {
        proxy: 'https://trefle.beta.pole-emploi.fr/0.8/'
    }
}
