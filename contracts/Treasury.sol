// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "./TokenPayable.sol";

/*
  By default, the owner of an Ownable contract is the account that deployed it.
*/
<<<<<<< HEAD
contract Treasury is Ownable {
    struct Proposal {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;
    mapping(address => uint256) public voteCounts;
=======
contract Treasury is Ownable, TokenPayable {
    constructor(address _token) TokenPayable(_token) {}
>>>>>>> upstream/main

    // Function to deposit Ether into the contract
    function deposit() external payable {
        require(
            msg.value > 0,
            "Treasury: Deposit amount should be greater than zero"
        );

        // The balance of the contract is automatically updated
    }

    // Function to withdraw Ether from the contract to specified address
    function withdraw(uint256 amount, address receiver) external onlyOwner {
        require(
            address(receiver) != address(0),
            "Treasury: receiver is zero address"
        );
        require(
            address(this).balance >= amount,
            "Treasury: Not enough balance to withdraw"
        );

        (bool send, ) = receiver.call{value: amount}("");
        require(send, "To receiver: Failed to send Ether");
    }

    // Function to allow the owner to withdraw the entire balance
    function withdrawAll() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "Treasury: No balance to withdraw");

        (bool send, ) = msg.sender.call{value: balance}("");
        require(send, "To owner: Failed to send Ether");
    }

    // Function to get the contract balance
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

<<<<<<< HEAD
    // Function to create a new proposal
    function createProposal(string memory proposalName) external onlyOwner {
        uint256 proposalId = proposals.length + 1;
        Proposal memory newProposal = Proposal(proposalId, proposalName, 0);
        proposals.push(newProposal);
    }

    // Function to vote for a proposal
    function vote(uint256 proposalId) external {
        require(hasVoted[msg.sender] == false, "Treasury: Already voted");
        require(proposalId > 0 && proposalId <= proposals.length, "Treasury: Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId - 1];
        proposal.voteCount += 1;
        voteCounts[msg.sender] += 1;
        hasVoted[msg.sender] = true;
    }

    // Function to get the vote count for a proposal
    function getVoteCount(uint256 proposalId) external view returns (uint256) {
        require(proposalId > 0 && proposalId <= proposals.length, "Treasury: Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId - 1];
        return proposal.voteCount;
    }

    // Function to get the total number of proposals
    function getProposalCount() external view returns (uint256) {
        return proposals.length;
    }

    // Function to get the vote count for a voter
    function getVoterVoteCount(address voter) external view returns (uint256) {
        return voteCounts[voter];
    }

    // Function to check if a voter has voted
    function hasVoted(address voter) external view returns (bool) {
        return hasVoted[voter];
=======
    // TokenPayable functions
    function approveToken(uint256 _amount) external onlyOwner {
        _approveToken(_amount);
    }

    function getTokenBalance() external view returns (uint256) {
        return _getTokenBalance();
    }

    function depositToken(uint256 _amount) external {
        _depositToken(_amount);
    }

    function withdrawToken(
        uint256 _amount,
        address _receiver
    ) external onlyOwner {
        _withdrawToken(_amount, _receiver);
    }

    function withdrawAllToken() external onlyOwner {
        _withdrawAllToken();
>>>>>>> upstream/main
    }
}
