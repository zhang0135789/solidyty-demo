//SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0 < 0.7.0;

/**

  众筹里面需要有2类角色：接收者和捐赠者，其中接收者可以对应多个捐赠者。
  接收者：接收者地址、众筹总金额、当前众筹金额、捐赠者的个数
  捐赠者： 捐赠者地址、捐赠金额

*/
contract CrowdFunding {

  //捐赠者对象
  struct Funder {
    address funder_address; // 捐赠者地址
    uint money; // 捐赠金额
  }

  //接受者对象
  struct Needer {
    address payable needer_address; // 接受者地址
    uint goal; //众筹总金额
    uint amount; //当前众筹金额
    uint funder_count; //捐赠者数量
    mapping(uint => Funder) map; //捐赠者列表
  }

  uint public neederId; //众筹对象id

  mapping(uint => Needer) public needer_map; //通过id将接受者信息关联


  constructor() public {
  }


  //发起众筹
  function createCrowdFunding(address payable _address , uint _goal) public {
    // 众筹对象id加1
    neederId++;
    // 创建接受者对象，并通过id与其绑定
    needer_map[neederId] = Needer(_address,_goal,0,0);
  }

  //发起捐赠
  function contribute(uint _neederId , uint _amount) public payable {
    // 通过id获取接受者对象
    Needer storage _needer = needer_map[_neederId];
    // 当前接受者金额加上获赠的金额
    _needer.amount += _amount;
    //捐赠人数加1
    _needer.funder_count++;
    // 将接受者id与捐赠者绑定在一起
    _needer.map[_needer.funder_count] = Funder(msg.sender , _amount);

  }

  //根据众筹id检查是否完成众筹
  function isCompelte(uint _neederId) public returns(bool) {
    // 通过id获取接受者对象
    Needer storage _needer = needer_map[_neederId];
    // 判断筹集资金是否达到与其目标
    if(_needer.amount >= _needer.goal) {
      //将众筹到的资金转移到接受者合约地址
      _needer.needer_address.transfer(_needer.amount);
      return true;
    }
    return false;
  }

}
