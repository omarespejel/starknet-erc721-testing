%lang starknet

from starkware.cairo.common.uint256 import Uint256

from src.interfaces.IERC721Original import IERC721Original

// ---------
// CONSTANTS
// ---------

const OWNER = 111;
const ADDRESS_TO_MINT = 222;
const NAME = 1590066861370246896902429777552750;
const SYMBOL = 5129044;


// ---------
// TESTS
// ---------

@external
func __setup__() {
    %{ 
        declared = declare("lib/cairo_contracts/src/openzeppelin/token/erc721/presets/ERC721MintableBurnable.cairo")
        prepared = prepare(declared, [ids.NAME, ids.SYMBOL, ids.OWNER])
        context.erc721_original_address = deploy(prepared).contract_address
    %}
    return ();
}

@external
func test_erc721_original_deploy{syscall_ptr: felt*, range_check_ptr}() {

    tempvar erc721_original_address: felt;

    %{  
        ids.erc721_original_address = context.erc721_original_address
    %}

    let (name) = IERC721Original.name(contract_address=erc721_original_address);
    let (symbol) = IERC721Original.symbol(contract_address=erc721_original_address);
    let (owner) = IERC721Original.owner(contract_address=erc721_original_address);
    
    assert NAME = name;
    assert SYMBOL = symbol;
    assert OWNER = owner;

    return ();
}

@external
func test_erc721_original_mint{syscall_ptr: felt*, range_check_ptr}(){

    tempvar erc721_original_address: felt;
    tempvar address_to_mint: felt;

    %{  
        ids.erc721_original_address = context.erc721_original_address
    %}

    %{ stop_prank_owner = start_prank(ids.OWNER, ids.erc721_original_address) %}
    IERC721Original.mint(erc721_original_address, ADDRESS_TO_MINT, Uint256(low = 1, high= 0));
    %{ stop_prank_owner() %}

    let (owner_minted) = IERC721Original.ownerOf(contract_address=erc721_original_address, tokenId=Uint256(low = 1, high= 0));
    assert ADDRESS_TO_MINT = owner_minted;

    return ();
}
