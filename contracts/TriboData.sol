pragma solidity ^0.4.11;

import "./Ownable.sol";

/**
 * @title TriboBase
 * @dev This defines what a Tribe is and how to create one
 */
contract TriboBase is Ownable {

  event NewTribe(
    address indexed owner,
    uint indexed _id,
    string name,
    string description
  );


  struct Tribe {
    address founder;
    string name;
    string description;
    uint memberCount;
    string profileImage;
    string coverImage;
  }

  Tribe[] public tribes;

  function _createTribe(string _name, string _description) internal returns (uint) {
    require(bytes(_name).length < 30);
    require(bytes(_description).length < 1000);

    Tribe memory _tribe = Tribe({
      founder: msg.sender,
      name: _name,
      description: _description,
      memberCount: 1,
      profileImage: '',
      coverImage: ''
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

  function getNumberOfTribes() public constant returns (uint) {
    return tribes.length;
  }

}
