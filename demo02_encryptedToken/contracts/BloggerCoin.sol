//SPDX-License-Identifier: MIT
pragma solidity >= 0.4.24 < 0.7.0;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

contract BloggerCoin is StandardToken{

  string public name = "BloggerCoin";
  string public symbol = "RMB";
  uint8 public decimals = 2;
  uint256 public INITIAL_SUPPLY = 666666;

  constructor() public {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
  }


}
