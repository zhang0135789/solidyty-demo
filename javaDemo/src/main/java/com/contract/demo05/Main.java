package com.contract.demo05;

import com.contract.common.Consts;
import org.web3j.abi.datatypes.Type;
import org.web3j.crypto.Credentials;
import org.web3j.crypto.WalletUtils;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.http.HttpService;

import java.util.List;

/**
 * @Author: zz
 * @Description: 合约调用
 * @Date: 10:52 AM 10/10/20
 * @Modified By
 */
public class Main {


    public static void main(String[] args) throws Exception{
// 1.默认连接到 http://localhost:8545/
        Web3j web3j = Web3j.build(new HttpService());
        // 2.获取凭证
        // TODO 此处的助记词  没有生成 testrpc 对应 m/44'/60'/0'/0/{account_index} 标准的私钥，所以无法注册
        Credentials credentials = WalletUtils.loadBip39Credentials(Consts.PASSWORD, Consts.MNEMONIC);
        // 3.加载合约
        UserManagerment contract = UserManagerment.load(Consts.ADDRESS, web3j, credentials, Consts.GAS_PRICE,
                Consts.GAS_LIMIT);
        // 4.调用合约
        // 检查注册
        Boolean isRegister = contract.checkRegister("张三").send().getValue();
        System.out.println("用户名‘张三’是否被注册：" + isRegister);

        // 注册 TODO
//        contract.register("0xe586ff3e53abf616f7678ee6a945b295d2b5f20d", "张三", "123").send();

        isRegister = contract.checkRegister("张三").send().getValue();
        System.out.println("用户名‘张三’是否被注册：" + isRegister);
        // 登录
        Boolean canLogin = contract.doLogin("张三", "123").send().getValue();
        if (canLogin) {
            System.out.println("登录成功");
        } else {
            System.out.println("登录失败");
        }
        // 获得用户信息
        System.out.println("张三信息如下：");
        List<Type> userInfo = contract.getUserInfoByUserName("张三").send();
        for (Type info : userInfo) {
            System.out.println(info.toString());
        }
        // 系统用户人数
        int userNum = contract.getTotalUserNum().send().getValue().intValue();
        System.out.println("总共的用户数：" + userNum);
        // 输出所有用户信息
        for (int i = 0; i < userNum; i++) {
            List<Type> user = contract.getAllUserInfos(i).send();
            for (Type info : user) {
                System.out.println(info.toString());
            }
        }
        // 5.关闭连接
        web3j.shutdown();
    }

}
