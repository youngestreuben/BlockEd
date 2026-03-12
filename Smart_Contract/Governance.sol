// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Governance {
    struct Proposal {
        string description;
        uint256 voteCount;
        bool executed;
        mapping(address => bool) voters;
    }

    mapping(uint256 => Proposal) public proposals;
    uint256 public proposalCount;

    event ProposalCreated(uint256 proposalId, string description);
    event Voted(uint256 proposalId, address voter);

    function createProposal(string memory _description) public {
        proposalCount++;
        Proposal storage p = proposals[proposalCount];
        p.description = _description;
        p.voteCount = 0;
        p.executed = false;
        emit ProposalCreated(proposalCount, _description);
    }

    function vote(uint256 _proposalId) public {
        Proposal storage p = proposals[_proposalId];
        require(!p.voters[msg.sender], "Already voted");
        p.voters[msg.sender] = true;
        p.voteCount++;
        emit Voted(_proposalId, msg.sender);
    }

    function getVotes(uint256 _proposalId) public view returns (uint256) {
        return proposals[_proposalId].voteCount;
    }
}
