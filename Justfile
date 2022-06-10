set positional-arguments

alias t := test

selector sig:
  #!/bin/sh
  sig=$(cast sig $1)
  echo -n $sig | xclip -selection clipboard
  echo $sig "(copied to clipboard)"

test *args='':
  forge test --ffi --fork-url $ETH_RINKEBY_URL --fork-block-number $ETH_BLOCK_NUMBER $@

ethernaut id:
  forge script test/$1*.sol --ffi --rpc-url $ETH_RINKEBY_URL -vvv --broadcast --private-key $ETH_RINKEBY_PRIV_KEY

ethernaut-slow id:
  forge script test/$1*.sol --ffi --rpc-url $ETH_RINKEBY_URL -vvv --broadcast --private-key $ETH_RINKEBY_PRIV_KEY --slow

status:
  node scripts/status.js