# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs qmake-utils

DESCRIPTION="MIPS Simulator"
HOMEPAGE="http://spimsimulator.sourceforge.net/"
SRC_URI="http://127.0.0.1:8000/static/${P}.tar"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc xspim qt5"

RDEPEND="xspim? ( media-fonts/font-adobe-100dpi
	x11-libs/libXaw
	x11-libs/libXp )"
DEPEND="${RDEPEND}
	xspim? ( x11-misc/imake
		x11-proto/xproto )
	qt5? ( dev-qt/qtcore:5 
			dev-qt/qtwidgets 
			dev-qt/qtprintsupport
			dev-qt/qthelp )
	>=sys-apps/sed-4
	sys-devel/bison"
# test hangs forever, disabling it
RESTRICT="test"

src_prepare() {
	# fix bugs 240005 and 243588
	#eapply "${FILESDIR}/${P}-r1-respect_env.patch"

	#fix bug 330389
	#sed -i -e 's:-12-\*-75-:-14-\*-100-:g' xspim/xspim.c || die

	if use qt5; then
		einfo "Applying QtSpim.pro patch"
		sed -i 's/$(MOVE) ${QMAKE\_FILE\_PATH}\/${QMAKE\_FILE\_BASE}.qhc ${QMAKE\_FILE\_OUT};//' QtSpim/QtSpim.pro
	fi

	default
}

src_configure() {
	#tc-export CC
	#emake -C spim configuration

	#if use xspim; then
	#	emake -C xspim configuration
	#fi
	if use qt5; then
		cd QtSpim
		eqmake5 QtSpim.pro
		cd ..
	fi
}

src_compile() {
	emake DESTDIR="${EPREFIX}" -C spim

	if use xspim; then
		emake DESTDIR="${EPREFIX}" EXCEPTION_DIR=/var/lib/spim \
			-C xspim -j1 xspim
	fi

	if use qt5; then
		export QT_SELECT=qt5
		qhelpgenerator QtSpim/help/qtspim.qhp -o QtSpim/help/qtspim.qhc
		#qtchooser -qt=qt5-x86_64-pc-linux-gnu
		#cd QtSpim
		#eqmake5 DESTDIR="${EPREFIX}" 
		#cd ..
		emake DESTDIR="${EPREFIX}" -Wall -C QtSpim
	fi
}

src_install() {
	#emake DESTDIR="${ED}" -C spim install
	dodir /usr/bin
	einfo "DESTDIR=${D}"
	emake DESTDIR="${D}" -C spim install
	newman Documentation/spim.man spim.1

	if use xspim; then
		emake DESTDIR="${D}" -C xspim install
		newman Documentation/xspim.man xspim.1
	fi

	if use qt5; then
		install -Dm755 QtSpim/QtSpim "${D}/usr/bin/QtSpim"
		newman Documentation/qtspim.man qtspim.1
	fi

	doicon "${FILESDIR}"/xspim.svg
	make_desktop_entry xspim xSPIM xspim "ComputerScience;Science;Education"
	make_desktop_entry QtSpim QtSPIM xspim "ComputerScience;Science;Education"

	dodoc Documentation/SPIM-cs.wisc.edu.html
	dodoc ChangeLog README
	if use doc ; then
		dodoc Documentation/TeX/{cycle,spim}.ps
	fi
}

src_test() {
	emake -C spim test
}
