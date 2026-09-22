// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract GopanToken is ERC20,ERC20Burnable,Ownable{

    constructor() ERC20("GopanToken","GPT") Ownable(msg.sender){
        _mint(msg.sender,1_000_000 * 10 ** 18);
    }
}