%lang starknet

from starkware.cairo.common.uint256 import Uint256

@contract_interface
namespace IERC721Original {
    func name() -> (name: felt) {
    }

    func symbol() -> (symbol: felt) {
    }

    func owner() -> (owner: felt) {
    }

    func mint(to: felt, tokenId: Uint256) {
    }

    func ownerOf(tokenId: Uint256) -> (owner: felt) {
    }
}