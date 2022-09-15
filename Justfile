set positional-arguments

alias t := test

alias g := gas

selector sig:
  #!/bin/sh
  sig=$(cast sig $1)
  echo -n $sig | xclip -selection clipboard
  echo $sig "(copied to clipboard)"

test *args='':
  forge test --ffi --fork-url $ETH_RINKEBY_URL --fork-block-number 10800000 $@

test-single *args='':
  forge test --ffi --fork-url $ETH_RINKEBY_URL --fork-block-number 10800000 --match-contract Ethernaut$1 $2

debug *args='':
  forge debug --fork-url $ETH_RINKEBY_URL --fork-block-number 10800000 /$1-*.sol --target-contract Ethernaut$1 --sig "test()"

gas:
  forge test --match-contract GasTest --gas-report
