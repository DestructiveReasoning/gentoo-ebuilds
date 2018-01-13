# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="An open source VHDL compiler and simulator"
HOMEPAGE="http://ghdl.free.fr"
SRC_URI="https://github.com/ghdl/ghdl/archive/v$PV.tar.gz"

LICENSE="GNU GPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+mcode llvm"
REQUIRED_USE="mcode? ( !llvm )"

DEPEND="dev-lang/gnat-gpl llvm? ( >=sys-devel/llvm-3.5.0 >=sys-devel/clang-3.5.0 )"
RDEPEND="${DEPEND}"

CONFIG_PARAMS="--prefix=/usr/local"

CONF_INSTRUCTIONS="\
	If GNATMAKE can't be found, symlink /usr/bin/gnatmake-x.x.x to /usr/bin/gnatmake\n \
	i.e. # ln -s /usr/bin/gnatmake-6.3.0 /usr/bin/gnatmake"

BUILD_INSTRUCTIONS="\
	If it says no ADA compiler is installed, use gcc-config to select appropriate gcc compiler\n \
	i.e. # gcc-config x86_64-pc-linux-gnu-6.3.0"

pkg_setup() {
	GNATMAKE=$(ls /usr/bin | grep gnatmake | head -n1)
	dosym /usr/bin/$GNATMAKE /usr/bin/gnatmake
}

src_configure() {
	if use llvm; then
		CONFIG_PARAMS="--with-llvm-config $CONFIG_PARAMS"
	fi
	./configure $CONFIG_PARAMS || die $CONF_INSTRUCTIONS
}

src_compile() {
	emake || die $BUILD_INSTRUCTIONS
}

src_install() {
	emake DESTDIR="${D}" install
}
