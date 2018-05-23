/*
 * Blockchain Capital Token Smart Contract.  Copyright © 2018 by Argon Investments Management.
 * Consulting.
 * Author: Mikhail Vladimirov <mikhail.vladimirov@gmail.com>
 */
pragma solidity ^0.4.1;

import "./StandardToken.sol";
import "./TransferAuthorizer.sol";

/**
 * Blockchain Capital Token Smart Contract.
 */
contract BCAPToken is StandardToken {
  /**
   * Create new Blockchain Capital Token contract with given token issuer
   * address and transfer authorizer.
   *
   * @param _tokenIssuer address of token issuer
   * @param _transferAuthorizer transfer authorizer to use
   */
  function BCAPToken (
    address _tokenIssuer, TransferAuthorizer _transferAuthorizer)
    public StandardToken (_tokenIssuer) {
    owner = _tokenIssuer;
    transferAuthorizer = _transferAuthorizer;
  }

  /**
   * Freeze token transfers.
   */
  function freezeTransfers () public {
    require (msg.sender == owner);

    if (!transfersFrozen) {
      transfersFrozen = true;
      Freeze ();
    }
  }

  /**
   * Unfreeze token transfers.
   */
  function unfreezeTransfers () public {
    require (msg.sender == owner);

    if (transfersFrozen) {
      transfersFrozen = false;
      Unfreeze ();
    }
  }

  /**
   * Transfer given number of tokens from message sender to given recipient.
   *
   * @param _to address to transfer tokens to the owner of
   * @param _value number of tokens to transfer to the owner of given address
   * @return true if tokens were transferred successfully, false otherwise
   */
  function transfer (address _to, uint256 _value)
    public returns (bool success) {
    if (transfersFrozen) return false;
    else if (!transferAuthorizer.transferAuthorized (
      this, msg.sender, _to, _value)) return false;
    else return AbstractToken.transfer (_to, _value);
  }

  /**
   * Transfer given number of tokens from given owner to given recipient.
   *
   * @param _from address to transfer tokens from the owner of
   * @param _to address to transfer tokens to the owner of
   * @param _value number of tokens to transfer from given owner to given
            recipient
   * @return true if tokens were transferred successfully, false otherwise
   */
  function transferFrom (address _from, address _to, uint256 _value)
  public returns (bool success) {
    if (transfersFrozen) return false;
    else if (!transferAuthorizer.transferAuthorized (
      this, _from, _to, _value)) return false;
    else return AbstractToken.transferFrom (_from, _to, _value);
  }

  /**
   * Set transfer authorizer to be used by smart contract.
   *
   * @param _transferAuthorizer transfer authorizer to use
   */
  function setTransferAuthorizer (TransferAuthorizer _transferAuthorizer)
    public {
    require (msg.sender == owner);

    transferAuthorizer = _transferAuthorizer;
  }

  /**
   * Logged when transfers were frozen.
   */
  event Freeze ();

  /**
   * Logged when transfers were unfrozen.
   */
  event Unfreeze ();

  /**
   * Address of the owner of smart contract.  Only owner is allowed to
   * freeze/unfreeze transfers.
   */
  address internal owner;

  /**
   * Transfer authorizer used by smart contract.
   */
  TransferAuthorizer internal transferAuthorizer;

  /**
   * Whether transfers are currently frozen or not.
   */
  bool internal transfersFrozen = false;
}
