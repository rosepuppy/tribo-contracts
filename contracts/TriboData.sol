pragma solidity ^0.4.11;

import "./Ownable.sol";

/**
 * @title TriboBase
 * @dev This defines what a Tribe is and how to create one
 */
contract TriboData is Ownable {

// *************************************
// Schemas
// *************************************

  struct User {
    uint userId;
    address wallet;
    uint[] memberships;
    uint primaryMembership;
  }

  struct Tribe {
    uint userId;
    string name;
    string description;
    string profileImage;
    string coverImage;
    uint[] memberships;
  }

  struct Membership {
    uint membershipId;
    address owner;
    uint tribeId;
    uint32 voteCount;
    uint32 votesForSale;
    uint salePrice;
  }

  User[] public users;
  Tribe[] public tribes;
  Membership[] public memberships;

  // 1:1 lookup_indexes
  mapping (address => uint) userWalletToId;

// *************************************
// Tribe events/functions
// *************************************

// events
  event NewTribe(
    address indexed owner,
    uint indexed _id,
    string name,
    string description
  );

// functions
  function createTribe(string _name, string _description) public returns (uint) {
    require(bytes(_name).length < 30);
    require(bytes(_description).length < 1000);

    uint newTribeId = tribes.length;
    uint newMembershipId = membership.length;

    Membership memory _founder = Membership({
      uint membershipId;
      address owner;
      uint tribeId;
      uint32 voteCount;
      uint32 votesForSale;
      uint salePrice;
    });

    Tribe memory _tribe = Tribe({
      founder: msg.sender,
      name: _name,
      description: _description,
      memberCount: 1,
      profileImage: '',
      coverImage: ''
      memberships: []
    });

    uint newTribeId = tribes.push(_tribe) - 1;

    NewTribe(
      msg.sender,
      newTribeId,
      _tribe.name,
      _tribe.description
    );

    return newTribeId;
  }
}
