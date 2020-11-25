package com.contract.demo05;

import com.contract.common.BlockChainConfig;
import com.contract.utils.WalletUtil;
import com.my.contract.Contracts_Hzwq_sol_Hzwq;
import org.web3j.abi.FunctionEncoder;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.Function;
import org.web3j.abi.datatypes.Type;
import org.web3j.crypto.Credentials;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.methods.request.Transaction;
import org.web3j.protocol.core.methods.response.TransactionReceipt;
import org.web3j.protocol.http.HttpService;

import java.math.BigInteger;
import java.util.Arrays;

/**
 * @Author: zz
 * @Description:
 * @Date: 6:26 PM 11/24/20
 * @Modified By
 */
public class Main2 {

    public static void main(String[] args) throws Exception {

        Web3j web3j = Web3j.build(new HttpService("http://192.168.15.105:8545"));
        // 2.获取凭证
        // TODO 此处的助记词  没有生成 testrpc 对应 m/44'/60'/0'/0/{account_index} 标准的私钥，所以无法注册

//        Credentials credentials = WalletUtils.loadBip39Credentials(Consts.PASSWORD, Consts.MNEMONIC);

        Credentials credentials = WalletUtil.getCredentials(BlockChainConfig.MNEMONIC);

        // 3.加载合约
        Contracts_Hzwq_sol_Hzwq hzwqContract = Contracts_Hzwq_sol_Hzwq.load(
                BlockChainConfig.CONTRACT_ADDRESS, web3j,
                credentials, BlockChainConfig.GAS_PRICE,
                BlockChainConfig.GAS_LIMIT);
        // 4.调用合约
        // 检查注册
        Boolean examineResult = hzwqContract.examine().send().getValue();

        String onlycode = hzwqContract.onlyCode().send().getValue();

        Boolean checkJson = hzwqContract.checkJson().send().getValue();


        TransactionReceipt send = hzwqContract.signature().send();
        System.out.println("end");


//        Function function = new Function(
//                "functionName",  // function we're calling
//                Arrays.asList(),  // Parameters to pass as Solidity Types
//                Arrays.asList(new TypeReference<Type>() {})
//        );

//        String encodedFunction = FunctionEncoder.encode(function);
//        Transaction transaction = Transaction.createFunctionCallTransaction(
//                "from",
//                new BigInteger("123"),
//                BlockChainConfig.GAS_PRICE,
//                BlockChainConfig.GAS_LIMIT,
//                BlockChainConfig.CONTRACT_ADDRESS,
//                new BigInteger("100"),
//                encodedFunction);
//
//        org.web3j.protocol.core.methods.response.EthSendTransaction transactionResponse =
//                web3j.ethSendTransaction(transaction).sendAsync().get();

//        String transactionHash = transactionResponse.getTransactionHash();



        // 5.关闭连接
        web3j.shutdown();
    }
}
