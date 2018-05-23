/*
 * Standard Token Smart Contract.  Copyright © 2018 by Argon Investments Management.
 * Author: Mikhail Vladimirov <mikhail.vladimirov@gmail.com>
 */
pragma solidity ^0.4.20;

import "./AbstractToken.sol";

/**
 * Standard Token Smart Contract that implements ERC-20 token with special
 * unlimited supply "token issuer" account.
 */
contract StandardToken is AbstractToken {
  uint256 constant private MAX_UINT256 =
    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

  /**
   * Create new Standard Token contract with given "token issuer" account.
   *
   * @param _tokenIssuer address of "token issuer" account
   */
  function StandardToken (address _tokenIssuer) public AbstractToken () {
    tokenIssuer = _tokenIssuer;
    accounts [_tokenIssuer] = MAX_UINT256;
  }

  /**
   * Get total number of tokens in circulation.
   *
   * @return total number of tokens in circulation
   */
  function totalSupply () public constant returns (uint256 supply) {
    return safeSub (MAX_UINT256, accounts [tokenIssuer]);
  }

  /**
   * Get number of tokens currently belonging to given owner.
   *
   * @param _owner address to get number of tokens currently belonging to the
            owner of
   * @return number of tokens currently belonging to the owner of given address
   */
  function balanceOf (address _owner)
    public constant returns (uint256 balance) {
    return _owner == tokenIssuer ? 0 : AbstractToken.balanceOf (_owner);
  }

  /**
   * Address of "token issuer" account.
   */
  address private tokenIssuer;
}
