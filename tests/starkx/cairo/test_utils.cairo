%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc

from contracts.starkx.limits import createRoot
from contracts.starkx.structs import Order, Limit
from contracts.starkx.utils import initLimit, limitExists

@external
func test_check_limit_exists{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> ():
    alloc_locals
    
    #  -Inf (root)
    #           \
    #            \
    #             5  
    #           /   \
    #          3     8
    #        /  \   /  \
    #       2    4  6   9
    let (local root : Limit*) = createRoot()

    let (local limit : Limit*) = alloc()
    assert limit.limitPrice = 6

    let (res) = limitExists(root, limit)
    
    return ()
end