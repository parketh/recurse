%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math_cmp import is_le
from contracts.starkx.structs import Limit, Order
from contracts.starkx.constants import MIN_VALUE

## Initialise limit object.
##
func initLimit(limit: Limit*):
    assert limit.limitPrice = MIN_VALUE  # Variation - set MIN_VALUE here rather than in limits.cairo
    assert limit.size = 0
    assert limit.totalVolume = 0
    assert limit.parent = cast(0, Limit*)
    assert limit.leftChild = cast(0, Limit*)
    assert limit.rightChild = cast(0, Limit*)
    assert limit.headOrder = cast(0, Order*)
    assert limit.tailOrder = cast(0, Order*)
    return ()
end

## Check if the given price level (value) exists in the given limit tree (root).
##   - Returns 1 if limitPrice is found
##   - Returns 0 if end of list was reached and limitPrice was not found
##   - Returns -1 if limitPrice was not found before end of list was reached
##
func limitExists{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    } (root : Limit*, limit : Limit*) -> (res : felt):
    alloc_locals

    if root.parent == 0:
        if root.rightChild == 0:
            return (0)
        end
    end
    
    local currentLimit: Limit* = root
    let (res) = checkLimit(currentLimit, root, limit)

    return (res)
end

## Recursively checks if the price level exists in the limit tree. 
##
func checkLimit{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    } (currentLimit : Limit*, root : Limit*, limit : Limit*) -> (res : felt):
    if currentLimit.limitPrice == limit.limitPrice:
        return (1)
    end

    if currentLimit.leftChild == 0:
        if currentLimit.rightChild == 0:
            return (0)
        else: 
            let (is_less_than) = is_le(currentLimit.limitPrice, limit.limitPrice)
            if is_less_than == 1:
                let (res) = checkLimit(currentLimit.rightChild, root, limit)
                return (res)
            else:
                return (-1)
            end
        end
    else:
        if currentLimit.rightChild == 0:
            let (is_less_than) = is_le(limit.limitPrice, currentLimit.limitPrice)
            if is_less_than == 1:
                let (res) = checkLimit(currentLimit.leftChild, root, limit)
                return (res)
            else:
                return (-1)
            end
        else: 
            return (-1)
        end
    end
end