#!/usr/bin/python

#
#   Functions to help with scripting
#   @author Martin Dagarin
#   @version 1
#   @since 19/03/2019
#

#
#   Checks if OpenVPN file has configuration option enabled
#   @param file Path to OpenVPN config file
#   @param opt Option to check for
#   @return Returns True if found, else false
#

def conf_hasOpt(file, opt):
    with open(file, "r") as f:
        for line in f:
            line = line.strip()
            if line.startswith(opt):
                return True
        return False

#
#   Finds option which is enabled in config
#   @param file Path to OpenVPN config file
#   @param opts Array of options, which to check
#   @return Returns first options which was found or None
#
def conf_optFindFirst(file, opts):
    with open(file, "r") as f:
        for line in f:
            line = line.strip()
            for opt in opts:
                if line.startswith(opt):
                    return opt
        return None

#
#   Replaces $VARIABLES in file with values
#   @param file Path to file
#   @param var Array of tuples with key value ("$KEY","VALUE")
#
def conf_envsubst(file, vars):
    with open(file, "r") as f:
        lines = f.readlines()
    with open(file, "w") as f:
        for line in lines:
            # Dont proces comments
            if not line.strip().startswith("#"):
                for kv in vars:
                    line = line.replace(kv[0],kv[1])
            f.write(line)