// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract CreativeBar is ERC20("CreativeBar", "xCRTV"){
    using SafeMath for uint256;
    IERC20 public crtv;

    constructor(IERC20 crtv) public {
        crtv = _crtv;
    }

    // Enter the bar. Pay some CRTVs. Earn some shares.
    function enter(uint256 _amount) public {
        uint256 totalCRTV = crtv.balanceOf(address(this));
        uint256 totalShares = totalSupply();
        if (totalShares == 0 || totalcrtv == 0) {
            _mint(msg.sender, _amount);
        } else {
            uint256 what = _amount.mul(totalShares).div(totalCRTV);
            _mint(msg.sender, what);
        }
        crtv.transferFrom(msg.sender, address(this), _amount);
    }

    // Leave the bar. Claim back your CRTVs.
    function leave(uint256 _share) public {
        uint256 totalShares = totalSupply();
        uint256 what = _share.mul(crtv.balanceOf(address(this))).div(totalShares);
        _burn(msg.sender, _share);
        crtv.transfer(msg.sender, what);
    }
}
