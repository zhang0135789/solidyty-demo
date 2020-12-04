package com.contract.common;


import java.math.BigInteger;
import java.util.concurrent.atomic.AtomicReference;

/**
 * @Author: zz
 * @Description: 区块链服务接口相关配置项
 * @Date: 4:52 PM 11/6/20
 * @Modified By
 */
public class BlockChainConfig {


    public static final String MNEMONIC
            =
            "myth like bonus scare over problem client lizard pioneer submit female collect";
    public static final String CONTRACT_ADDRESS = "0x9561C133DD8580860B6b7E504bC5Aa500f0f06a7";
    // 节点地址
    public static String RPC = "http://localhost:8545/";

    // GAS价格
    public static BigInteger GAS_PRICE = BigInteger.valueOf(2000_000_000L);

    // GAS上限
    public static BigInteger GAS_LIMIT = BigInteger.valueOf(4_300_000L);

    // 交易费用
    public static BigInteger GAS_VALUE = BigInteger.valueOf(100_000L);



}
