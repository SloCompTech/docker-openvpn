#!/usr/bin/python

#
#	Script for adding username & password to database
#	@author Martin Dagarin
#	@version 1
#	@since 22/03/2020
#
# Usage:
# adduser.py <databasepath> <username> <password>
#

import binascii
import hashlib
import json
import os
import sys

def getExtensionFromPath(path):
	return os.path.splitext(path)[1][1:]

def hash_password(password):
  """Hash a password for storing."""
  salt = hashlib.sha256(os.urandom(60)).hexdigest().encode('ascii')
  pwdhash = hashlib.pbkdf2_hmac('sha512', password.encode('utf-8'), 
                              salt, 100000)
  pwdhash = binascii.hexlify(pwdhash)
  return (salt + pwdhash).decode('ascii')

def main():
  if len(sys.argv) < 4:
    print('Usage: %s <database> <username> <password>' % sys.argv[0])
    sys.exit(1)
  
  username = sys.argv[2].strip()
  password = hash_password(sys.argv[3].strip())

  database = sys.argv[1].strip()
  dbextention = getExtensionFromPath(database)

  if dbextention == 'csv':
    with open(database, 'a') as file:
      file.write('%s,%s\n' % (username, password))
  elif dbextention == 'json':
    if os.path.exists(database):
      with open(database, 'r') as file: # Open file
        data = json.loads(file.read())
    else:
      data = []
    data.append({
      'username': username,
      'password': password
    })
    with open(database, 'w') as file:
      file.write(json.dumps(data, indent=2))

if __name__ == '__main__':
	main()
