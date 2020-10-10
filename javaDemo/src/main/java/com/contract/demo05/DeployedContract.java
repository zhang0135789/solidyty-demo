package com.contract.demo05;

import com.contract.common.Consts;
import okhttp3.OkHttpClient;
import org.web3j.crypto.Credentials;
import org.web3j.crypto.WalletUtils;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.http.HttpService;

import java.util.concurrent.TimeUnit;

/**
 * @Author: zz
 * @Description: 合约部署
 * @Date: 3:44 PM 10/9/20
 * @Modified By
 */
public class DeployedContract {

    public static void main(String[] args) throws Exception {
        // 1. 默认连接到 http://localhost:8545/
        OkHttpClient.Builder builder = new OkHttpClient.Builder();
        builder.connectTimeout(30*1000, TimeUnit.MILLISECONDS);
        builder.writeTimeout(30*1000, TimeUnit.MILLISECONDS);
        builder.readTimeout(30*1000, TimeUnit.MILLISECONDS);
        OkHttpClient httpClient = builder.build();

        Web3j web3j = Web3j.build(new HttpService(Consts.RPC , httpClient , false));
        // 2. 获取凭证
        Credentials credentials = WalletUtils.loadBip39Credentials(null, Consts.MNEMONIC);
        // 3.部署合约
        UserManagerment contract = UserManagerment.deploy(web3j, credentials, Consts.GAS_PRICE, Consts.GAS_LIMIT).send();
        // 4.获得合约地址
        System.out.println(contract.getContractAddress());

    }
}
