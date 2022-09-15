pragma solidity 0.8.10;

import { Test } from "forge-std/Test.sol";
import { Gas } from "src/Gas.sol";

contract GasTest is Test {
  Gas gas;

  function setUp() public {
    gas = new Gas();
  }

  function test_1() public {
    gas.toString(101);
  }

  function test_2() public {
    gas.toString2(101);
  }

  function test_3() public {
    gas.uint2str(101);
  }
}
