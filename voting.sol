//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


contract Voting {

struct Candidate {
    uint id;
    string name;
    uint voteCount;
}

address public owner;
Candidate[] public candidates;

mapping(address => bool) public hasVoted;

constructor() {
    owner = msg.sender;

    candidates.push(Candidate(1, "Candidate A", 0));
    candidates.push(Candidate(2, "Candidate B", 0));
    candidates.push(Candidate(3, "Candidate C", 0));
}

// Allow voters to vote
function vote(uint candidateId) public {
    require(!hasVoted[msg.sender],
        "You have already voted!");

    require(candidateId > 0 &&
        candidateId <= candidates.length,
        "Invalid candidate ID!");

    candidates[candidateId - 1].voteCount++;

    hasVoted[msg.sender] = true;
}

// Get candidate details
function getCandidate(uint id)
    public view returns (uint, string memory, uint) {

    require(id > 0 && id <= candidates.length,
        "Invalid candidate ID!");

    Candidate memory c = candidates[id - 1];

    return (c.id, c.name, c.voteCount);
}

// Get total number of candidates
function getCandidateCount()
    public view returns (uint) {
    return candidates.length;
}

// Get election winner
function getWinner()
    public view returns (string memory) {

    uint winningVoteCount = 0;
    uint winnerIndex = 0;

    for (uint i = 0; i < candidates.length; i++) {
        if (candidates[i].voteCount > winningVoteCount) {
            winningVoteCount = candidates[i].voteCount;
            winnerIndex = i;
        }
    }

    require(winningVoteCount > 0, "No votes yet!");

    return candidates[winnerIndex].name;
}
}