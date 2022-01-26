// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
contract MyContract{
    
    mapping(address => uint256) public AddressToAmountFunded;
    address[] public funders;
    address public owner;
    constructor() public {
        owner = msg.sender;
    }

    function fund() public payable{
        AddressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }
    
    function getPrice() public view payable{
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer * 10000000000);         
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }
}