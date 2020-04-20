# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_7 python3_6 )
inherit distutils-r1

DESCRIPTION="Hydra is a framework for elegantly configuring complex packages."
HOMEPAGE="https://hydra.cc"
SRC_URI="https://github.com/facebookresearch/hydra/archive/0.11.3.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/typing-extensions
		>=dev-python/omegaconf-2.2.0_rc23"
RDEPEND="${DEPEND}"
BDEPEND=""

python_prepare() {
	einfo "CHANGING THINGS"
	sed -i -e "s/find_packages()/find_packages(exclude=['tests'])/" setup.py || die
}
