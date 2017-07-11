pragma solidity ^0.4.11;

contract BubbleCoin {

	// key/value store
	mapping(address => uint) balances;

	// map owner to multiple spenders.
	mapping(address => mapping(address => uint)) approved;

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

	// allow spender spend money from the owner account.
	function approve(address _spender, uint _value) returns (bool success) {

		if (balances[msg.sender] < _value) {
			return false;
		}

		approved[msg.sender][_spender] = _value;
		return true;
	}

	// the amount of tokens the spender can spend from owners account
	function allowance(address _owner, address _spender) constant returns (uint remaining) {
		return approved[_owner][_spender];
	}

	function transferFrom(address _from, address _to, uint _value) returns (bool success) {
		if (
			balances[_from] >= _value &&
			_value > 0 &&
			approved[_from][msg.sender] >= _value // if caller of the function can spend this money
		) {
			balances[_from] -= _value;
			approved[_from][msg.sender] -= _value;
			balances[_to] += _value;

			return true;
		}

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
