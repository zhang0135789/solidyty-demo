//SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0 < 0.7.4;


import "./provableAPI.sol";


contract Hzwq5 is usingProvable{

  constructor() public{
    OAR = OracleAddrResolverI(0x6f485C8BF6fc43eA212E93BBF8ce046C7f1cb475);

  }

  string public ETHUSD;
  event LogConstructorInitiated(string nextStep);
  event LogPriceUpdated(string price);
  event LogNewOraclizeQuery(string description);


  function __callback( bytes32 _myid, string memory _result ) public {
    if (msg.sender != provable_cbAddress()) revert();
    ETHUSD = _result;
    emit LogPriceUpdated(_result);
  }

  function signature(string memory _url ) payable public {
    if (provable_getPrice("URL") > address(this).balance) {
      emit LogNewOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
    } else {
      emit LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer..");
      provable_query("URL", _url);
    }
  }

}
