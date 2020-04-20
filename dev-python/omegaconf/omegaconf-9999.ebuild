# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 python3_7 )
inherit distutils-r1 git-r3

DESCRIPTION="Flexible Python configuration system. The last one you will ever need."
HOMEPAGE="https://github.com/omry/omegaconf"
EGIT_REPO_URI="https://github.com/omry/omegaconf.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pyyaml
		dev-python/typing-extensions"
RDEPEND="${DEPEND}"
BDEPEND="dev-python/pytest-runner
		dev-python/pytest-mock"
