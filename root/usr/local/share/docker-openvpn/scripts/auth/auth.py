#!/usr/bin/python

#
#	Script for checking OpenVPN name & password
#	@author Martin Dagarin
#	@version 2
#	@since 22/03/2020
#
#	Usage:
#	username=<username> password=<password> auth.py # via-env
#	auth.py <filepath> # via-file
#	# For OpenVPN auth-pass-verify hook just set path to stript
#
#	NOTE: Please set DATABASE to use
#

import argparse
import binascii
import hashlib
import json
import os
import sys


# Settings
DATABASE = os.path.dirname(sys.argv[0]) + '/db.csv'

# Return code of program
STATUS_SUCCESS = 0
STATUS_ERROR = 1

def getExtensionFromPath(path):
	return os.path.splitext(path)[1][1:]

#
#	Verify stored hash password
#
def verify_password(stored_password, provided_password):
    """Verify a stored password against one provided by user"""
    salt = stored_password[:64]
    stored_password = stored_password[64:]
    pwdhash = hashlib.pbkdf2_hmac('sha512', 
                                  provided_password.encode('utf-8'), 
                                  salt.encode('ascii'), 
                                  100000)
    pwdhash = binascii.hexlify(pwdhash).decode('ascii')
    return pwdhash == stored_password
#
# Gets OpenVPN env vars
#	@returns username and password as dictionary
#
def ovpn_viaEnv():
	try:
		return { 
			'username': os.environ['username'], 
			'password': os.environ['password']
		}
	except KeyError:
		return { 'username': None, 'password': None }


#
#	Reads OpenVPN auth file
#	@returns username and password as dictionary
#
def ovpn_viaFile(path):
	if not os.path.exists(path) or not os.path.isfile(path):
		return { 'username': None, 'password': None }
	
	with open(path,"r") as file:
		return { 'username': file.readline(), 'password': file.readline() }

#
#	Authenticates user with database
#	@return True if OK, else False
#
def authenticate(database, credentials):
	# Check if username specified
	if credentials['username'] is None:
		return False
	
	# Remove leading & tailing spaces
	credentials['username'] = credentials['username'].strip()
	if credentials['password'] is not None:
		credentials['password'] = credentials['password'].strip()

	dbextension = getExtensionFromPath(database).lower()

	try:
		if dbextension == 'json':
			#
			#	.json user database
			#	stored in format:
			#	{
			#		"username": "username",
			# 	"password": "password"	
			# }
			#
			with open(database, 'r') as file: # Open file
				data = json.loads(file.read()) # Parse JSON content
				for user in data: # Iterate through list of users
					if user['username'].strip() == credentials['username']:
						if verify_password(user['password'], credentials['password']): # Success
							print('Login: User %s' % credentials['username'])
							return True
						else: # Wrong password
							print('Login: Wrong password for %s' % credentials['username'])
							return False
			# Username not found
			print('Login: Username %s not found' % credentials['username'])
			return False
		elif dbextension == 'csv':
			#
			#	.csv user database
			#	format:
			#	username,password
			#
			with open(database, 'r') as file: # Open file
				for line in file:
					line = line.strip()
					if len(line) == 0: # Skip empty lines
						continue
					cells = line.split(',')
					if len(cells) < 2: # Skip faulty lines
						continue
					if cells[0].strip() == credentials['username']:
						if verify_password(cells[1].strip(), credentials['password']): # Success
							print('Login: User %s' % credentials['username'])
							return True
						else: # Wrong password
							print('Login: Wrong password for %s' % credentials['username'])
							return False
				# Username not found
				print('Login: Username %s not found' % credentials['username'])
				return False
	except IOError:
		pass

	# Authentication method not found
	print('Authentication method not found')
	return False


def main():
	if len(sys.argv) < 2: # File not specified
		credentials = ovpn_viaEnv()
	else: # File specified
		credentials = ovpn_viaFile(sys.argv[1])
	
	if authenticate(DATABASE, credentials):
		print('Success')
		sys.exit(STATUS_SUCCESS)
	else:
		print('Fail')
		sys.exit(STATUS_ERROR)

if __name__ == '__main__':
	main()
