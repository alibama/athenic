// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract Admin is Ownable {

  // The proxy contract that will be upgraded 
  Proxy public proxy;

  // Address allowed to upgrade proxy
  address public adminSigner = 0xalibamaEth;

  constructor(address _proxy) {
    proxy = Proxy(_proxy);
  }

  /** 
   * Upgrade proxy to new implementation
   */
  function upgrade(address newImplementation) external {
    require(msg.sender == adminSigner, "Only admin signer can upgrade");
    proxy.upgradeTo(newImplementation);
  }

  /**
   * Change admin signature 
   */  
  function changeAdminSigner(address newSigner) external onlyOwner {
    adminSigner = newSigner;
  }

  /**
  * @dev Fallback function to deposit Ether.
  */
  fallback() external payable {
    require(msg.value > 0, "Cannot forward 0 Ether");
    payable(adminSigner).transfer(msg.value);
  }

  /**
  * @dev Function to withdraw any Ether balance in contract.
  */
  function withdrawBalance() external onlyOwner {
    payable(owner()).transfer(address(this).balance);
  }

  /**
  * @dev Function to destroy contract when no longer needed.
  */
  function destroy() external onlyOwner {
    selfdestruct(payable(owner()));
  }

}
