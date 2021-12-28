//Smart contract for cloud storage

// SPDX-License-Identifier: UNLICENSED 

pragma solidity ^0.5.0;

contract DCloud {
  string public name = 'DCloud';
  uint public fileCount = 0;
  mapping(uint => File) public files;

  struct File {
    uint fileId;
    string fileHash;
    uint fileSize;
    string fileType;
    string fileName;
    string fileDescription;
    uint uploadTime;
    address payable uploader;
  }

  event FileUploaded(
    uint fileId,
    string fileHash,
    uint fileSize,
    string fileType,
    string fileName, 
    string fileDescription,
    uint uploadTime,
    address payable uploader
  );

  constructor() public {
  }

  function uploadFile(string memory _fileHash, uint _fileSize, string memory _fileType, string memory _fileName, string memory _fileDescription) public {
    
    // Makes sure the file hash exists
    require(bytes(_fileHash).length > 0);
    
    // Makes sure file type exists
    require(bytes(_fileType).length > 0);
    
    // Makes sure file description exists
    require(bytes(_fileDescription).length > 0);
    
    // Makes sure file fileName exists
    require(bytes(_fileName).length > 0);
    
    // Makes sure uploader address exists
    require(msg.sender!=address(0));
    
    // Makes sure file size is more than 0
    require(_fileSize>0);

    // Increment file id
    fileCount ++;

    // Add File to the contract
    files[fileCount] = File(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, now, msg.sender);
    // Trigger an event
    emit FileUploaded(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, now, msg.sender);
  }
}
