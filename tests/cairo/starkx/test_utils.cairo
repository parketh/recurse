%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc

from contracts.starkx.limits import createRoot
from contracts.starkx.structs import Order, Limit
from contracts.starkx.utils import limitExists
from contracts.starkx.constants import MIN_VALUE

func initLimit(limitPrice: felt) -> (ptr_limit: Limit*):
    alloc_locals
    let (local ptr_limit : Limit*) = alloc()
    assert ptr_limit.limitPrice = limitPrice
    return (ptr_limit)
end

@external
func test_check_limit_exists{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> ():
    alloc_locals
    
    #  -Inf (root)
    #            \
    #             5  
    #           /   \
    #          3     8
    #        /  \  
    #       2    4 

    let (root) = createRoot()
    let (five) = initLimit(5)
    assert root.rightChild = five
    let (three) = initLimit(3)
    let (eight) = initLimit(8)
    assert five.leftChild = three
    assert five.rightChild = eight
    let (two) = initLimit(2)
    let (four) = initLimit(4)
    assert three.leftChild = two
    assert three.rightChild = four

    let (limit) = initLimit(4)
    let (res) = limitExists(root, limit)
    
    return ()
end