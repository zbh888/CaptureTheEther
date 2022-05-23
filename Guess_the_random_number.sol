// sol1
pragma solidity ^0.4.21;

contract Solve {
    uint8 answer;
    bytes32 public previousBlockHash = 0xa64ec3af6374aabca27f14aae3ce0a823f7027d7f5f2efb57515e8088a78a474;
    uint256 noww = 1653055059;

    function solveF() public returns (uint8) {
        answer = uint8(keccak256(previousBlockHash, noww));
    }

    function anw() public view returns(uint8) {
        return answer;
    }

}

// sol2

$ curl https://ropsten.infura.io/v3/95d8dd42bc6140308160208c98b266e3 \
-X POST \
-H "Content-Type: application/json" \
-d '{"jsonrpc":"2.0","method":"eth_getStorageAt","params": ["0x32163dE8e1d4cc1fE78045B486B3a2B5dF221673", "0x0", "latest"],"id":1}'

Where "0x32163dE8e1d4cc1fE78045B486B3a2B5dF221673" is the deployed challenge contract address

(Using infura api)
