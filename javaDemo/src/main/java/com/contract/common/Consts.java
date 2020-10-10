package com.contract.common;

import lombok.Data;

import java.math.BigInteger;

/**
 * @Author: zz
 * @Description:
 * @Date: 3:43 PM 10/9/20
 * @Modified By
 */
@Data
public class Consts {

    // 节点地址
    public static String RPC = "http://localhost:8545/";

    // GAS价格
    public static BigInteger GAS_PRICE = BigInteger.valueOf(2000_000_000L);

    // GAS上限
    public static BigInteger GAS_LIMIT = BigInteger.valueOf(4_300_000L);

    // 交易费用
    public static BigInteger GAS_VALUE = BigInteger.valueOf(100_000L);

    // 账户密码
    public static String PASSWORD = "";

    // 账户助记词
    public static String MNEMONIC = "forget list latin genuine ordinary mad reflect bridge hedgehog vocal waste type";

    // 账户文件路径
    public static String PATH = "E:/BlockChain/node5/data/keystore/UTC--2020-04-11T07-54-54.678177700Z--12d4e53d6f017a2a62807876ec41fc97a0f60a71";

    // 合约地址，第一次部署之后记录下来
    public static String ADDRESS = "0xeCC512A7921aBEF07Cb516F5BD0eeae1daAdAc78";

    // chain id,在创世区块中定义的
    public static byte CHAINID = (byte) 666;

}
