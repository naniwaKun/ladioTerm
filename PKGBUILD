pkgname=ladioterm-git
pkgver=$(date +%Y%m%d_%H%M)
pkgrel=1
pkgdesc="A net ladio client " 
arch=('i686' 'x86_64')
url="https://github.com/naniwaradio/ladioTerm"
license=('MIT')
depends=('bash' 'mpv' 'ruby' 'streamripper')
optdepends=('zeromq')
makedepends=('git')
source=('ladioTerm::git+https://github.com/naniwaradio/ladioTerm.git')
md5sums=('SKIP')

pkgver() {
        cd "$srcdir/ladioTerm"
        # Use the tag of the last commit
        git describe --long | sed -E 's/([^-]*-g)/r\1/;s/-/./g'
}


package() {
        cd "$srcdir/ladioTerm"
        install -Dm755 "ladio" "${pkgdir}/usr/bin/ladio"
        install -Dm755 "ladioRec" "${pkgdir}/usr/bin/ladioRec"
        install  -Dm755 "ladio.rb" "${pkgdir}/usr/bin/ladio.rb"
}
