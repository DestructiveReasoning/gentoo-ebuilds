# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=""
inherit perl-module

DESCRIPTION="A framework to produce sprite animations using ASCII art."
HOMEPAGE="search.cpan.org/dist/Term-Animation"
SRC_URI="http://search.cpan.org/CPAN/authors/id/K/KB/KBAUCOM/Term-Animation-$PV.tar.gz"
LICENSE="GPL, PerlArtistic"
IUSE=""
REQUIRED_USE=""
DEPEND="dev-perl/Curses"
RDEPEND="${DEPEND}"

#LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_configure() {
	perl Makefile.PL
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}
