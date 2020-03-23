#!/usr/bin/with-contenv bash
#
#   Runs custom init scripts
#
set -e

# Global
for script in /config/hooks/init/*
do
  # Skip non-files and non-executables
  if [ ! -f "$script" ] || [ ! -x "$script" ]; then
    continue
  fi

  # Run script
  $script
done
