// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.2 <  0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SoulboundToken is ERC721URIStorage, Ownable {
    uint256 private _tokenIdCounter;
    //컨트랙트 생성자
    constructor() ERC721("SoulboundToken", "SBT") {}
    //SBT 민팅 함수
    function mintSBT(address user, string memory tokenURI) public onlyOwner {
        //SBT토큰 소유 여부 확인
        require(!_addressHasToken(user), "User already has an SBT token");
        //토큰 ID증가, SBT부여
        _tokenIdCounter += 1;
        _safeMint(user, _tokenIdCounter);
        _setTokenURI(_tokenIdCounter, tokenURI);
    }
    //SBT토큰 소유 여부 확인 함수
    function _addressHasToken(address user) private view returns (bool) {
        for (uint256 i = 1; i <= _tokenIdCounter; i++) {
            if (ownerOf(i) == user) {
                return true;
            }
        }
        return false;
    }
}
