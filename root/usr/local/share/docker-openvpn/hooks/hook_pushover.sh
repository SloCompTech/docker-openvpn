#!/bin/bash

#
#   Pushover notification script
#   @author Martin Dagarin
#   @version 1
#   @since 19/03/2019
#
#   @see https://pushover.net/api
#

URL="https://api.pushover.net/1/messages.json"

# Here put your app token
APP_TOKEN=""

# Here put your user or group key
USER_KEY=""

TITLE="TestTile"
MESSAGE="This is test message"

# Send to server
curl -s \
  --form-string "token=${APP_TOKEN}" \
  --form-string "user=${USER_KEY}" \
  --form-string "title=${TITLE}" \
  --form-string "message=${MESSAGE}" \
  ${URL}