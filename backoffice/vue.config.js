module.exports = {
    publicPath: "/0.7/explorer/",
    assetsDir: "src/assets/",
    devServer: {
        proxy: 'https://trefle.beta.pole-emploi.fr/0.7/'
    }
}
