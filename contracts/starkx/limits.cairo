%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.dict_access import DictAccess

from contracts.starkx.utils import initLimit
from contracts.starkx.constants import MIN_VALUE
from contracts.common.dictionary import (
    create_dict, add_entries, read_entry, update_entry
)

## Create a Limit structure as root and return a ptr to it.
##
## DEPRECATED
# func createRoot() -> (ptr_limit : Limit*):
#     alloc_locals
#     let (local ptr_limit : Limit*) = alloc()
#     initLimit(ptr_limit)
#     # ptr_limit = MIN_VALUE     Omitted - set limitPrice to MIN_VALUE in limits.cairo rather than here
#     return (ptr_limit)
# end
func createRoot() -> (ptr_limit : DictAccess*):
    alloc_locals
    let (dict) = create_dict(initial_value=0)
    update_entry{dict_ptr=dict}(0, 0, MIN_VALUE) # set limitPrice = -INFINITY
    return (dict)
end



## Add a new Limit struct to the given limit tree.
##  - Asserts that the limit does not yet exist.
##  - Also sets left and right child to NULL.
##
# func addNewLimit(root : Limit*, limit: Limit*) -> (res: felt):
#     alloc_locals
    
#     let (exists) = limitExists(root, limit)
#     if exists == 1:
#         return (0)
#     end


# end 