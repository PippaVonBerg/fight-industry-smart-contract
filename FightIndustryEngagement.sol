// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FightIndustryEngagement {
    address public chaosTheorySociety;
    address public fightLeague;
    uint256 public totalContractValue;
    uint256 public numberOfMilestones;
    
    struct Milestone {
        string description;
        uint256 amount;
        bool completed;
        bool paid;
    }
    
    Milestone[] public milestones;
    
    constructor(address _fightLeague, uint256 _totalContractValue, uint256 _numberOfMilestones) {
        chaosTheorySociety = msg.sender;
        fightLeague = _fightLeague;
        totalContractValue = _totalContractValue;
        numberOfMilestones = _numberOfMilestones;
    }
    
    function addMilestone(string memory _description, uint256 _amount) public {
        require(msg.sender == chaosTheorySociety, "Only CTS can add milestones");
        milestones.push(Milestone(_description, _amount, false, false));
    }
    
    function completeMilestone(uint256 _milestoneId) public {
        require(msg.sender == fightLeague, "Only the fight league can complete milestones");
        require(_milestoneId < milestones.length, "Invalid milestone ID");
        milestones[_milestoneId].completed = true;
    }
    
    function releaseMilestonePayment(uint256 _milestoneId) public {
        require(msg.sender == fightLeague, "Only the fight league can release payments");
        require(_milestoneId < milestones.length, "Invalid milestone ID");
        require(milestones[_milestoneId].completed, "Milestone not completed");
        require(!milestones[_milestoneId].paid, "Payment already released");
        milestones[_milestoneId].paid = true;
        // Payment logic would go here
    }
}
