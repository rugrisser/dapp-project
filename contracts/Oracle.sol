pragma solidity ^0.8.0;

import "github.com/provable-things/ethereum-api/provableAPI.sol";

contract Oracle is usingProvable {
    string public price;
    event LogNewProvableQuery(string description);
    event LogNewPrice(string price);

    mapping (bytes32 => address) public provable_to_wallet;

    function updatePrice() external payable {
        emit LogNewProvableQuery("Provable query was sent, standing by for the answer...");
        bytes32 query_id = provable_query("URL", "json(https://www.cbr-xml-daily.ru/daily_json.js).Valute.Value");
        provable_to_wallet[query_id] = msg.sender;
    }

    function __callback(bytes32 myid, string memory result) public {
        require(msg.sender == provable_cbAddress());
        price = result;
        emit LogNewPrice(price);
    }
}
