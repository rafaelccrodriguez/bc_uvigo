pragma solidity ^0.4.25;
import "./zombieattack.sol";
import "./erc721.sol";
import "./safemath.sol";
contract ZombieOwnership is ZombieAttack, ERC721 {
  using SafeMath for uint256;
  mapping (uint => address) zombieApprovals;
  function balanceOf(address _owner) external view returns (uint256) {
    return ownerZombieCount[_owner];
  }
