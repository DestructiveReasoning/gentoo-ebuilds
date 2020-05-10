# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Your personal research assistant."
HOMEPAGE="https://www.zotero.org"
SRC_URI="https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64&version=${PV}
	x86?	( https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86&version=${PV} ) -> ${P}.tar.bz2"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

MY_PN=${PN/-bin/}
MY_BIN=zotero

src_unpack() {
	if [[ -n ${A} ]]; then
		unpack ${A}
	fi
	mv "${WORKDIR}/Zotero_linux"-* "${WORKDIR}/${P}"
}

src_install() {
	insinto /opt/${MY_PN}
	doins -r .
	fperms +x /opt/${MY_PN}/${MY_BIN}
	fperms +x /opt/${MY_PN}/${MY_BIN}-bin
	dosym /opt/${MY_PN}/${MY_BIN} /usr/bin/${MY_BIN}
}
