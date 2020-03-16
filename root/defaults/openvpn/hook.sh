#!/bin/bash
#
# Hook script runner for OpenVPN
#

# Check if hook exist
if [ ! -d "hooks/$1" ]; then
  exit 0
fi

# Run each script
for script in hooks/$1/*
do
  # Skip non-files and non-executables
  if [ ! -f "$script" ] || [ ! -x "$script" ]; then
    continue
  fi

  # Run script
  $script ${@:2}

  # Check exit status
  exit_status=$?
  if [ $exit_status -ne 0 ]; then
    # Script returned non 0 exit code
    exit $exit_status
  fi
done
