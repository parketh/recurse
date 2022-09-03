%lang starknet

from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.alloc import alloc

from contracts.common.dictionary import (
    create_dict, add_entries, read_entry, update_entry
)

@external
func test_dictionary{range_check_ptr}():
    alloc_locals
    let (dict) = create_dict(initial_value=13)

    let (local keys : felt*) = alloc()
    let (local values : felt*) = alloc()
    assert keys[0] = 0 
    assert keys[1] = 1 
    assert values[0] = 5  
    assert values[1] = 0 
    let len = 2

    add_entries{dict_ptr=dict}(keys, values, len)

    # Check {key: value} pair is correct.
    let (key_0_val) = read_entry{dict_ptr=dict}(key=0)
    assert key_0_val = 5
    let (key_1_val) = read_entry{dict_ptr=dict}(key=1)
    assert key_1_val = 0
    let (key_2_val) = read_entry{dict_ptr=dict}(key=2)
    assert key_2_val = 13

    update_entry{dict_ptr=dict}(0, key_0_val, 6)

    let (key_0_val) = read_entry{dict_ptr=dict}(key=0)
    assert key_0_val = 6

    return ()
end
