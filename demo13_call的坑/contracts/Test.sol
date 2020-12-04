pragma solidity >= 0.5.0 < 0.7.4;

contract Test {
    function Test(){

    }



    uint public testMem;

    function testFunc1() returns (string resMes){
        testMem++;
        resMes = "try to modify testMem,but has no constant label";
    }

    function testFunc2() constant returns (string resMes){
        testMem--;
        resMes = "try to modify testMem and has constant label";
    }
}
