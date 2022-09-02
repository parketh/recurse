%lang starknet

from contracts.structs import Limit, Order

func initLimit(limit: Limit*):
    assert limit.limitPrice = 0
    assert limit.size = 0
    assert limit.totalVolume = 0
    assert limit.parent = cast(0, Limit*)
    assert limit.leftChild = cast(0, Limit*)
    assert limit.rightChild = cast(0, Limit*)
    assert limit.headOrder = cast(0, Order*)
    assert limit.tailOrder = cast(0, Order*)
    return ()
end


func limitExists(root : Limit*, limit : Limit*) -> (res : felt):
    alloc_locals

    if root.parent + rightChild == 0:
        return (0)
    end
    
    let (local currentLimit : Limit*) = root

    return (0)
end