// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {Test, console} from "forge-std/Test.sol";
import {GopanToken} from "../src/GopanToken.sol";

contract GopanTokenTest is Test {
    GopanToken public token;
    address public deployer = address(this);
    address public alice = address(0xA11ce);
    address public bob = address(0xB0b);

    function setUp() public {
        token = new GopanToken();
    }

    function testTotalSupplyOfGPT() public view {
        uint256 totalSupply = token.totalSupply();
        console.log(totalSupply);
        assertEq(totalSupply, 1_000_000 * 10 ** 18);
    }

    function testBalanceOfDeployerEqualsTotalSupply() public view {
        uint256 deployerBalance = token.balanceOf(deployer);
        uint256 totalSupply = token.totalSupply();
        assertEq(deployerBalance, totalSupply);
    }

    function testTransferGPT() public {
        uint256 transferAmount = 100 * 10 ** 18;
        token.transfer(alice, transferAmount);
        uint256 aliceBalance = token.balanceOf(alice);

        assertEq(aliceBalance, transferAmount);
    }

    function testBurnTokens() public {
        uint256 burnAmount = 50 * 10 ** 18;
        uint256 supplyBefore = token.totalSupply();

        token.burn(burnAmount);

        uint256 supplyAfter = token.totalSupply();
        assertEq(supplyAfter, supplyBefore - burnAmount);
        assertEq(token.balanceOf(address(this)), supplyBefore - burnAmount);
    }

    function testTransferRevertWhenTransferExceedsBalance() public {
        vm.prank(alice);
        vm.expectRevert();
        token.transfer(bob, 1);

        assertEq(token.balanceOf(bob), 0);
    }
}
