pragma solidity ^0.4.11;

contract BubbleCoin {

	// key/value store
	mapping(address => uint) balances;

	// number of coins in circulation
	uint supply;

	// ERC20 functions
	function totalSupply() constant returns(uint totalSupply) {
		return supply;
	}

	function balanceOf(address _owner) constant returns (uint balance) {
	    return balances[_owner];
	}

	function transfer(address _to, uint _value) returns (bool success) {
	    if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;

            //successful transaction
            return true;
	    }
	    // failed transaction
	    return false;
	}

	// custom functions
	function mint(uint numberOfCoins) {
		balances[msg.sender] += numberOfCoins;
		supply += numberOfCoins;
	}

	function getMyBalance() returns (uint balance) {
		return balances[msg.sender];
	}
}
