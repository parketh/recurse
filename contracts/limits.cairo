%lang starknet

from structs import Order, Limit, Book


## Create a Limit structure as root and return a ptr to it.
##
func createRoot() -> (ptr_limit : Limit*):
    local ptr_limit : Limit* = new Limit(
        assert limit.limitPrice = 0
        assert limit.size = 0
        assert limit.totalVolume = 0
        assert limit.orderCount = 0
        assert limit.parent = cast(0, Limit*)
        assert limit.leftChild = cast(0, Limit*)
        assert limit.rightChild = cast(0, Limit*)
        assert limit.headOrder = cast(0, Order*)
        assert limit.tailOrder = cast(0, Order*)
    )
    # Omitted: ptr_limit->limitPrice = -INFINITY;
    return (ptr_limit)
end

## Add a new Limit struct to the given limit tree.
##  - Asserts that the limit does not yet exist.
##  - Also sets left and right child to NULL.
##
func 