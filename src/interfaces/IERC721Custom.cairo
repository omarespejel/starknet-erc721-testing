%lang starknet

from starkware.cairo.common.uint256 import Uint256

@contract_interface
namespace IERC721Custom {
    func name() -> (name: felt) {
    }

    func symbol() -> (symbol: felt) {
    }

    func owner() -> (owner: felt) {
    }

    func get_animal_characteristics(token_id: Uint256) -> (sex: felt, legs: felt, wings: felt){
    }

    func get_last_tokenID() -> (tokenID: Uint256) {
    }

    func declare_animal(sex: felt, legs: felt, wings: felt) -> (token_id: Uint256){
    }

    func ownerOf(tokenId: Uint256) -> (owner: felt) {
    }
}