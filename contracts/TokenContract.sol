// SPDX-License-Identifier: Unlicenced
pragma solidity 0.8.30;

contract TokenContract {

    address public owner;
    struct Receivers {
        string name;
        uint256 tokens;
    }
    mapping(address => Receivers) public users;

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    constructor(){
        owner = msg.sender;
        users[owner].tokens = 100;
    }

    function double(uint _value) public pure returns (uint){
        return _value*2;
    }

    function register(string memory _name) public{
        users[msg.sender].name = _name;
    }

    function giveToken(address _receiver, uint256 _amount) onlyOwner public{
        _transferToken(_receiver, _amount);
    }

    // Centraliza a verificação do estoque e a movimentação, para que transferências manuais e compras usem a mesma regra.
    function _transferToken(address _receiver, uint256 _amount) internal {
        require(users[owner].tokens >= _amount, "Not enough tokens available");
        users[owner].tokens -= _amount;
        users[_receiver].tokens += _amount;
    }

    // `payable` permite receber Ether; o valor enviado compra a quantidade indicada.
    function buyTokens(uint256 _amount) public payable {
        // Exige exatamente 5 Ether por token, evitando aceitar pagamento insuficiente ou cobrar a mais.
        require(msg.value == _amount * 5 ether, "Send exactly 5 Ether per token");

        // Reutiliza a mesma verificação e transferência de tokens de giveToken.
        _transferToken(msg.sender, _amount);
    }

    // Expõe o Ether recebido pelo contrato; o resultado é devolvido em wei.
    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
