// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4 <0.9.0;

interface IXERC20Factory {
  /**
   * @notice Reverts when a non-owner attempts to call
   */

  error IXERC20Factory_NotOwner();

  /**
   * @notice Reverts when a lockbox is trying to be deployed from a malicious address
   */

  error IXERC20Factory_BadTokenAddress();

  /**
   * @notice Reverts when a lockbox is already deployed
   */

  error IXERC20Factory_LockboxAlreadyDeployed();

  /**
   * @notice Deploys an XERC20 contract using CREATE2
   * @dev _limits and _minters must be the same length
   * @param _name The name of the token
   * @param _symbol The symbol of the token
   * @param _burnerLimits The array of limits that you are adding (optional, can be an empty array)
   * @param _bridges The array of burners that you are adding (optional, can be an empty array)
   * @param _baseToken The address of the base ERC20 token if you are deploying a lockbox (optional, put address(0) if you dont want to deploy one)
   */

  function deploy(
    string memory _name,
    string memory _symbol,
    uint256[] memory _minterLimits,
    uint256[] memory _burnerLimits,
    address[] memory _bridges,
    address _baseToken
  ) external returns (address _xerc20, address _lockbox);

  /**
   * @notice Deploys an XERC20Lockbox contract using CREATE3
   *
   * @param _xerc20 The address of the xerc20 that you want to deploy a lockbox for
   * @param _baseToken The address of the base token that you want to lock
   */

  function deployLockbox(address _xerc20, address _baseToken) external returns (address _lockbox);

  /**
   * @notice Checks if an XERC20 is registered
   *
   * @param _xerc20 The address of the xerc20 that you want to check
   * @return _result True if the xerc20 is registered, false if not
   */

  function isXERC20(address _xerc20) external view returns (bool _result);

  /**
   * @notice Loops through the xerc20RegistryArray
   *
   * @param _start The start of the loop
   * @param _end The end of the loop
   * @return _lockboxes The array of xerc20s from the start to the end of the loop
   */

  function getRegisteredLockboxes(uint256 _start, uint256 _end) external view returns (address[] memory _lockboxes);

  /**
   * @notice Loops through the xerc20RegistryArray
   *
   * @param _start The start of the loop
   * @param _end The end of the loop
   * @return _xerc20s The array of xerc20s from the start to the end of the loop
   */

  function getRegisteredXERC20(uint256 _start, uint256 _end) external view returns (address[] memory _xerc20s);

  /**
   * @notice Returns the address of the lockbox for a given XERC20
   *
   * @param _xerc20 The address of the XERC20
   * @return _lockbox The address of the lockbox
   */

  function lockboxRegistry(address _xerc20) external view returns (address _lockbox);
}
