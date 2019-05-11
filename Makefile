# Copyright © 2018-2019 Vasili Karaev
# 
# This file is part of bt.
#
# bt is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# bt is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with bt.  If not, see <http://www.gnu.org/licenses/>.

PROGNAME := bt

PREFIX := /usr

all:
	@echo "Run 'make install' to install ${PROGNAME}"

install:
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@echo installing executable script in ${DESTDIR}${PREFIX}/bin
	@cp -p ${PROGNAME} ${DESTDIR}${PREFIX}/bin/${PROGNAME}

uninstall:
	@rm -f ${DESTDIR}${PREFIX}/bin/${PROGNAME}
