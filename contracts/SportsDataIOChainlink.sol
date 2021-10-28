pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract SportsDataIOChainlink is ChainlinkClient {
using Chainlink for Chainlink.Request;
  uint256 private fee;
  bytes32 private jobId;
  address private oracle;
  bytes32 public data;

  address payable owner;
    modifier onlyOwner {
    require(msg.sender == owner);
    _;
    }
  constructor(){
    setPublicChainlinkToken();
   oracle = 0xfF07C97631Ff3bAb5e5e5660Cdf47AdEd8D4d4Fd; // Oracle Address
   jobId = "1c8933936d6947258e462c666e9786a5"; //polygon
   fee = 0.1 * 10 ** 18; // 0.1 LINK (Varies by network)
    
  }
  function requestData
(

  
)
  public
  onlyOwner
  
{
  Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
  
  req.add("teamid", "508");
  sendChainlinkRequestTo(oracle, req, fee);
}
function fulfill(bytes32 _requestId, bytes32 _data)
  public
  recordChainlinkFulfillment(_requestId)
{
  data = _data;
}
  
}