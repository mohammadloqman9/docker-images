#!/bin/sh

# Copyright (C) 2007-2021 Crafter Software Corporation. All Rights Reserved.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as published by
# the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Check for conf file and generate if logrotate config file is not present
CONF_FILE=/etc/logrotate.conf
if [ ! -f "$CONF_FILE" ]; then
	cat logrotate.tpl.conf | envsubst > /etc/logrotate.conf
# Setup crafter user crontab
echo "$CRON_SCHEDULE /usr/sbin/logrotate /etc/logrotate.conf" | crontab -

# Run crontab through `tini`
exec tini $@
