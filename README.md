# Blockchain Capital Token Smart Contract

Blockchain Capital Token Smart Contract.
Copyright © 2018 by Argon Investments Management.

**Author:** Mikhail Vladimirov <mailto:mikhail.vladimirov@gmail.com>

## How to Deploy

In order to deploy Blockchain Capital Token Smart Contract you need the
following software to be properly installed on your system:

1.  Geth 1.6.5+ (https://geth.ethereum.org/)

Also, you need Ethereum node running on your system and synchronized with the
network. If you do not have one, you may run it via one of the following
commands depending on whether you want to connect to PRODNET or TESTNET:

    geth
    geth --testnet

If you are running Ethereum node for the first time, you may also add "--fast"
flag to speed up initial synchronization:

    geth --fast
    geth --testnet --fast

Also you need at least one account in your node. If you do not have any
accounts, you may create one using the following commands:

    geth attach
    > personal.newAccount ();
    > exit

It will ask you to choose passphrase and enter it twice, and it will output an
address of your new created account.

You will also need some ether on your primary account.

In order to deploy Blockchain Capital Token Smart Contract do the following:

1.  Go to the directory containing deployment script, i.e. file named
    `TokenDeploy.js`.
2.  Attach to your local Ethereum node: `geth attach`
3.  Set token issuer address like this:
    `var tokenIssuer = "0xe489665cc93a8e3286bdd70a4e513360bcb14a48";`
4.  Set transfer authorizer like this:
    `var transferAuthorizer = "0x0123456789012345678901234567890123456789";`
5.  Unlock your primary account:
    `personal.unlockAccount (web3.eth.accounts [0]);` (you will be
    asked for your passphrase here)
6.  Run deployment script: `loadScript ("TokenDeploy.js");`
7.  If everything will go fine, after several seconds you will see message like
    the following: `Deployed at ... (tx: ...)`,
    which means that your contract was deployed (message shows address of the
    contract and hash of the transaction the contract was deployed by)
