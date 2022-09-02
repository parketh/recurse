import os
import pytest

from starkware.starknet.testing.starknet import Starknet

# The path to the contract source code.
CONTRACT_FILE = os.path.join(
    os.path.dirname(__file__), "test_limits.cairo")

# The testing library uses python's asyncio. So the following
# decorator and the ``async`` keyword are needed.
@pytest.mark.asyncio
async def test_increase_balance():
    # Create the local Starknet network
    starknet = await Starknet.empty()

    # Deploy the contract
    contract = await starknet.deploy(CONTRACT_FILE)

    # Call createRoot()
    await contract.test_create_root().call()
