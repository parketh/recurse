%lang starknet

from starkware.cairo.common.default_dict import (
    default_dict_new, default_dict_finalize)
from starkware.cairo.common.dict import (
    dict_write, dict_read, dict_update)

# Returns the value for the specified key in a dictionary.
func create_dict{range_check_ptr}(
        keys : felt*, keys_len : felt, values : felt*, values_len : felt) -> (
        dict : DictAccess*):
    alloc_locals
    # First create an empty dictionary and finalize it.
    # All keys will initially have value 0.
    let initial_value = 0
    let (local dict) = default_dict_new(default_value=initial_value)

    # Finalize the dictionary. This ensures default value is correct.
    default_dict_finalize(
        dict_accesses_start=dict,
        dict_accesses_end=dict,
        default_value=initial_value)

    # Then add {key: val} pairs.
    add_entries(dict, keys, values, len)
    dict_write{dict_ptr=dict}(key=4, new_value=17)  # {4: 17}.
    dict_write{dict_ptr=dict}(key=10, new_value=6)  # {10: 6}.

    # Check {key: value} pair is correct.
    let (key_4_val) = dict_read{dict_ptr=dict}(key=4)
    assert key_4_val = 17

    # Update a key.
    dict_update{dict_ptr=dict}(key=4,
        prev_value=17, new_value=18)  # {4: 17} -> {4: 18}

    # Check that an unused key returns the default value.
    let (unused_key_999_val) = dict_read{dict_ptr=dict}(
        key=999)
    assert unused_key_999_val = 13

    # Get value of the requested keys.
    let (val_1) = dict_read{dict_ptr=dict}(key_1)
    let (val_2) = dict_read{dict_ptr=dict}(key_2)
    let (val_3) = dict_read{dict_ptr=dict}(key_3)
    return (val_1, val_2, val_3)
end

func add_entries(dict : DictAccess*, keys : felt*, values : felt*, len : felt):
    if keys_len == 0:
        return ()
    else:
        dict_write{dict_ptr=dict}(key=keys[0], new_value=values[0])
        add_entries(dict, keys + 1, values + 1, len - 1)
    end    
end