set positional-arguments

alias ty := test-yul
alias sel := selector

selector sig:
  #!/bin/sh
  sig=$(cast sig $1)
  echo -n $sig | xclip -selection clipboard
  echo $sig "(copied to clipboard)"

test-yul *args='':
  forge test --ffi --match-path test/yul-samples/**/*.d.sol $@

ethernaut id:
  forge script scripts/ethernaut/$1*.sol --tc Ethernaut03 --ffi --rpc-url $ETH_RINKEBY_URL -vvv --broadcast --private-key $ETH_RINKEBY_PRIV_KEY

ethernaut-slow id:
  forge script scripts/ethernaut/$1*.sol --tc Ethernaut03 --ffi --rpc-url $ETH_RINKEBY_URL -vvv --broadcast --private-key $ETH_RINKEBY_PRIV_KEY --slow