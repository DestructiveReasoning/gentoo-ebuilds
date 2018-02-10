# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Aquarium/sea animation in ASCII art."
HOMEPAGE="https://github.com/cmatsuoka/asciiquarium"
EGIT_REPO_URI="https://github.com/cmatsuoka/asciiquarium.git"
inherit git-r3

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Term-Animation"
RDEPEND="${DEPEND}"

src_install() {
	exeinto /usr/bin
	exeopts -m755
	doexe  asciiquarium
}
