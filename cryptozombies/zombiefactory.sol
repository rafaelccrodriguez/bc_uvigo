pragma solidity ^0.4.25;
import "./ownable.sol";
import "./safemath.sol";
contract ZombieFactory is Ownable {
  using SafeMath for uint256;
  event NewZombie(uint zombieId, string name, uint dna);
  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownTime = 1 days;
  struct Zombie {
