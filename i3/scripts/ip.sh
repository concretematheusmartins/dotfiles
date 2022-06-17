#!/usr/bin/env bash
#/scripts/ip.sh

# --------------------------------------------------------------------------------
# Copyright (C) 2020 Matheus Martins <3mhenrique@gmail.com>
# License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law
# --------------------------------------------------------------------------------
# Write ip external on i3 status interface

caminho="/scripts/Output/meuip"

echo $(curl -s ipinfo.io/ip) > $caminho && exit 0
