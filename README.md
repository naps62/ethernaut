# Ethernaut - solved with Foundry

## Caveats

- For some unknown reason, I can't run two tests in the same run. i.e.: `forge test` fails, but running each test individually works. This seems to fail at the `solve()` step
- 03 is not solvable in a trivial way, since it requires sending 10 separate transactions, which must go into different blocks, and each one must be calculated based on the blockhash
