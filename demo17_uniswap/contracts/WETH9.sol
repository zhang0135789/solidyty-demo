pragma solidity =0.5.16;

// 用ERC20包装后的eth
contract WETH9 {
    //代币名称
    string public name     = "Wrapped Ether";
    //
    string public symbol   = "WETH";
    uint8  public decimals = 18;

    event  Approval(address indexed src, address indexed guy, uint wad);
    event  Transfer(address indexed src, address indexed dst, uint wad);
    event  Deposit(address indexed dst, uint wad);
    event  Withdrawal(address indexed src, uint wad);

    //余额映射
    mapping (address => uint)                       public  balanceOf;
    //批准映射
    mapping (address => mapping (address => uint))  public  allowance;

    function() external payable {
        deposit();
    }

    //存款
    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    //取出存款
    function withdraw(uint wad) public {
        require(balanceOf[msg.sender] >= wad);
        balanceOf[msg.sender] -= wad;
        msg.sender.transfer(wad);
        emit Withdrawal(msg.sender, wad);
    }

    //存款总数量
    function totalSupply() public view returns (uint) {
        return address(this).balance;
    }

    //批准使用
    //@param guy 被批准使用的账户
    //@param wad 被批准使用的金额
    function approve(address guy, uint wad) public returns (bool) {
        allowance[msg.sender][guy] = wad;
        emit Approval(msg.sender, guy, wad);
        return true;
    }

    //交易
    //@param dst 接收地址
    //@param wad 金额
    function transfer(address dst, uint wad) public returns (bool) {
        return transferFrom(msg.sender, dst, wad);
    }


    function transferFrom(address src, address dst, uint wad)
    public
    returns (bool)
    {
        require(balanceOf[src] >= wad);

        if (src != msg.sender && allowance[src][msg.sender] != uint(-1)) {
            require(allowance[src][msg.sender] >= wad);
            allowance[src][msg.sender] -= wad;
        }

        balanceOf[src] -= wad;
        balanceOf[dst] += wad;

        emit Transfer(src, dst, wad);

        return true;
    }
}
