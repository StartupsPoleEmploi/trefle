let _currentTag = null

var View = {
    init () {
        this.on('before-mount', () => {
            _currentTag && _currentTag.unmount(true)
            _currentTag = this
        })
    }
}
