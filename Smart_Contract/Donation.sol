// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Donation {
    struct Project {
        string name;
        uint256 totalDonations;
        address owner;
    }

    mapping(uint256 => Project) public projects;
    mapping(uint256 => mapping(address => uint256)) public donations;
    uint256 public projectCount;

    event ProjectCreated(uint256 projectId, string name, address owner);
    event Donated(uint256 projectId, address donor, uint256 amount);

    function createProject(string memory _name) public {
        projectCount++;
        projects[projectCount] = Project(_name, 0, msg.sender);
        emit ProjectCreated(projectCount, _name, msg.sender);
    }

    function donate(uint256 _projectId) public payable {
        require(_projectId > 0 && _projectId <= projectCount, "Invalid project");
        donations[_projectId][msg.sender] += msg.value;
        projects[_projectId].totalDonations += msg.value;
        payable(projects[_projectId].owner).transfer(msg.value);
        emit Donated(_projectId, msg.sender, msg.value);
    }

    function getProject(uint256 _projectId) public view returns (Project memory) {
        return projects[_projectId];
    }

    function getDonation(uint256 _projectId, address _donor) public view returns (uint256) {
        return donations[_projectId][_donor];
    }
}
