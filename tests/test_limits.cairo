%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

from contracts.limits import createRoot
from contracts.structs import Order, Limit, Book
from contracts.utils import initLimit

@external
func test_create_root{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> ():
    alloc_locals
    let (local root : Limit*) = createRoot()
    
    assert root.limitPrice = 0
    assert root.size = 0
    assert root.totalVolume = 0
    assert root.parent = cast(0, Limit*)
    assert root.leftChild = cast(0, Limit*)
    assert root.rightChild = cast(0, Limit*)
    assert root.headOrder = cast(0, Order*)
    assert root.tailOrder = cast(0, Order*)
    
    return ()
end