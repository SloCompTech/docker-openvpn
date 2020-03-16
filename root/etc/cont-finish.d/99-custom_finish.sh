#!/usr/bin/with-contenv bash
#
#   Runs custom finish scripts
#
set -e

# Global
for script in /config/hooks/finish/*
do
  # Skip non-files and non-executables
  if [ ! -f "$script" ] || [ ! -x "$script" ]; then
    continue
  fi

  # Run script
  $script
done
