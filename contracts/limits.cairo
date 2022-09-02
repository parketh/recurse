%lang starknet

from starkware.cairo.common.alloc import alloc
from structs import Order, Limit, Book
from utils import initLimit

## Create a Limit structure as root and return a ptr to it.
##
func createRoot() -> (ptr_limit : Limit*):
    alloc_locals
    let (local ptr_limit : Limit*) = alloc()
    initLimit(ptr_limit)
    # Omitted: ptr_limit->limitPrice = -INFINITY;
    return (ptr_limit)
end

## Check if the given price level (value) exists in the given limit tree (root).
##
func limitExists(root : Limit*, limit : Limit*):
    
end


## Add a new Limit struct to the given limit tree.
##  - Asserts that the limit does not yet exist.
##  - Also sets left and right child to NULL.
##
func addNewLimit(root : Limit*, limit: Limit*) -> (res: felt):

end 