#!/bin/sh

address=$1

castcmd="cast --rpc-url $ETH_RINKEBY_URL"

level_log_completed_topic="0x9dfdf7e3e630f506a3dfe38cdbe34e196353364235df33e5a3b588488d9a1e78"
controller="0xd991431d8b033ddcb84dad257f4821e9d5b38c33"
sender="0x0077014b4c74d9b1688847386b24ed23fdf14be8"
level="0x9CB391dbcD447E645D6Cb55dE6ca23164130D008"

getlogs_params='{"topics": ["'$level_log_completed_topic'"], "address": "'$controller'", "fromBlock": "0xA53250"}'
getlogs_payload='{"jsonrpc": "2.0","method": "eth_getLogs", "params":['$getlogs_params'], "id":74}'

echo "$getlogs_payload"
curl -X POST $ETH_RINKEBY_URL --data "$getlogs_payload" 2> /dev/null
