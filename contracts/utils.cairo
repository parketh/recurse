%lang starknet

from structs import Limit

func initLimit(limit: Limit*):
    assert limit.limitPrice = 0
    assert limit.size = 0
    assert limit.totalVolume = 0
    assert limit.orderCount = 0
    assert limit.parent = cast(0, Limit*)
    assert limit.leftChild = cast(0, Limit*)
    assert limit.rightChild = cast(0, Limit*)
    assert limit.headOrder = cast(0, Order*)
    assert limit.tailOrder = cast(0, Order*)
end


func limitExists(root : Limit*, limit, Limit*):
    
end