//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "./lib/RLPEncode.sol";
import "hardhat/console.sol";

contract BlockHashVerifier {
    struct BlockHeader {
        bytes32 hash;
        bytes32 parent_hash;
        bytes32 uncles_hash;
        address author;
        bytes32 state_root;
        bytes32 transactions_root;
        bytes32 receipts_root;
        bytes log_bloom;
        uint256 difficulty;
        uint256 number;
        uint256 gas_limit;
        uint256 gas_used;
        uint256 timestamp;
        bytes extra_data;
        bytes32 mixHash;
        uint64 nonce;
        uint256 totalDifficulty;
    }

    function getBlockRlpData(BlockHashVerifier.BlockHeader memory header) internal pure returns (bytes memory data) {
        bytes[] memory list = new bytes[](15);

        list[0] = RLPEncode.encodeBytes(abi.encodePacked(header.parent_hash));
        list[1] = RLPEncode.encodeBytes(abi.encodePacked(header.uncles_hash));
        list[2] = RLPEncode.encodeAddress(header.author);
        list[3] = RLPEncode.encodeBytes(abi.encodePacked(header.state_root));
        list[4] = RLPEncode.encodeBytes(abi.encodePacked(header.transactions_root));
        list[5] = RLPEncode.encodeBytes(abi.encodePacked(header.receipts_root));
        list[6] = RLPEncode.encodeBytes(header.log_bloom);
        list[7] = RLPEncode.encodeUint(header.difficulty);
        list[8] = RLPEncode.encodeUint(header.number);
        list[9] = RLPEncode.encodeUint(header.gas_limit);
        list[10] = RLPEncode.encodeUint(header.gas_used);
        list[11] = RLPEncode.encodeUint(header.timestamp);
        list[12] = RLPEncode.encodeBytes(header.extra_data);
        list[13] = RLPEncode.encodeBytes(abi.encodePacked(header.mixHash));
        list[14] = RLPEncode.encodeBytes(abi.encodePacked(header.nonce));

        data = RLPEncode.encodeList(list);
    }

    function getBlockHash(BlockHashVerifier.BlockHeader memory header) public pure returns (bytes32 hash) {
        return keccak256(getBlockRlpData(header));
    }
}