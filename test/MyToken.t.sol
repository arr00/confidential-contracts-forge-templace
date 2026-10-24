// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

import {FhevmTest} from "forge-fhevm/FhevmTest.sol";
import {MyToken} from "../src/MyToken.sol";
import {FHE, euint64} from "@fhevm/solidity/lib/FHE.sol";

contract MyTokenTest is FhevmTest {
    MyToken public myToken;
    address public alice = makeAddr("alice");
    address public bob = makeAddr("bob");

    function setUp() public override {
        super.setUp();
        myToken = new MyToken("MyToken", "MTK", "https://mytoken.com", alice);
    }

    function test_mint(uint64 amount) public {
        vm.prank(alice);
        myToken.mint(bob, amount);

        assertEq(decrypt(myToken.confidentialBalanceOf(bob)), amount);
    }
}
