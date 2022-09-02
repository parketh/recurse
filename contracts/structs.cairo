%lang starknet

struct Order:
    member idNumber : felt
    member buyOrSell : felt  # 1 = buy, 0 = sell
    member shares : felt
    member limit : felt
    member entryTime : felt
    member eventTime : felt
    member nextOrder : Order*
    member prevOrder : Order*
    member parentLimit : Limit*
end

struct Limit:
    member limitPrice : felt
    member size : felt
    member totalVolume : felt
    member parent : Limit*
    member leftChild : Limit*
    member rightChild : Limit*
    member headOrder : Order*
    member tailOrder : Order*
end

struct Book:
    member buyTree : Limit*
    member sellTree : Limit*
    member lowestSell : Limit*
    member highestBuy : Limit*
end