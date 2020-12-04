package com.my.contract;

import org.bouncycastle.pqc.math.linearalgebra.BigEndianConversions;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.*;
import org.web3j.abi.datatypes.generated.Bytes32;
import org.web3j.crypto.Credentials;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.RemoteCall;
import org.web3j.protocol.core.methods.response.Log;
import org.web3j.protocol.core.methods.response.TransactionReceipt;
import org.web3j.tx.Contract;
import org.web3j.tx.TransactionManager;
import org.web3j.tx.gas.ContractGasProvider;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * <p>Auto generated code.
 * <p><strong>Do not modify!</strong>
 * <p>Please use the <a href="https://docs.web3j.io/command_line.html">web3j command line tools</a>,
 * or the org.web3j.codegen.SolidityFunctionWrapperGenerator in the
 * <a href="https://github.com/web3j/web3j/tree/master/codegen">codegen module</a> to update.
 *
 * <p>Generated with web3j version 3.6.0.
 */
public class Contracts_Hzwq_sol_Hzwq extends Contract {
    private static final String BINARY = "608060405234801561001057600080fd5b506101cd806100206000396000f3fe608060405234801561001057600080fd5b506004361061004c5760003560e01c80633bb05edc146100515780637060512f1461005157806373db08441461006d578063884db250146100ea575b600080fd5b6100596100f2565b604080519115158252519081900360200190f35b6100756100f7565b6040805160208082528351818301528351919283929083019185019080838360005b838110156100af578181015183820152602001610097565b50505050905090810190601f1680156100dc5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b610075610185565b600190565b6000805460408051602060026001851615610100026000190190941693909304601f8101849004840282018401909252818152929183018282801561017d5780601f106101525761010080835404028352916020019161017d565b820191906000526020600020905b81548152906001019060200180831161016057829003601f168201915b505050505081565b6040805160208101909152600081529056fea2646970667358221220b9baa731418c705e9f44331d2b4d4b5e9b77d9dfaaff6c8e213ae46a3020674464736f6c63430007030033";

    public static final String FUNC_ETHUSD = "ETHUSD";

    public static final String FUNC_CHECKJSON = "checkJson";

    public static final String FUNC_EXAMINE = "examine";

    public static final String FUNC_ONLYCODE = "onlyCode";

    public static final String FUNC_SIGNATURE = "signature";

    public static final String FUNC_CHECKJSONDATA = "checkJsonData";



    @Deprecated
    protected Contracts_Hzwq_sol_Hzwq(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        super(BINARY, contractAddress, web3j, credentials, gasPrice, gasLimit);
    }

    protected Contracts_Hzwq_sol_Hzwq(String contractAddress, Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, web3j, credentials, contractGasProvider);
    }

    @Deprecated
    protected Contracts_Hzwq_sol_Hzwq(String contractAddress, Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        super(BINARY, contractAddress, web3j, transactionManager, gasPrice, gasLimit);
    }

    protected Contracts_Hzwq_sol_Hzwq(String contractAddress, Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, web3j, transactionManager, contractGasProvider);
    }

    public static RemoteCall<Contracts_Hzwq_sol_Hzwq> deploy(Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(Contracts_Hzwq_sol_Hzwq.class, web3j, credentials, contractGasProvider, BINARY, "");
    }

    public static RemoteCall<Contracts_Hzwq_sol_Hzwq> deploy(Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(Contracts_Hzwq_sol_Hzwq.class, web3j, transactionManager, contractGasProvider, BINARY, "");
    }

    @Deprecated
    public static RemoteCall<Contracts_Hzwq_sol_Hzwq> deploy(Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        return deployRemoteCall(Contracts_Hzwq_sol_Hzwq.class, web3j, credentials, gasPrice, gasLimit, BINARY, "");
    }

    @Deprecated
    public static RemoteCall<Contracts_Hzwq_sol_Hzwq> deploy(Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        return deployRemoteCall(Contracts_Hzwq_sol_Hzwq.class, web3j, transactionManager, gasPrice, gasLimit, BINARY, "");
    }



    public RemoteCall<TransactionReceipt> ETHUSD() {
        final Function function = new Function(
                FUNC_ETHUSD,
                Arrays.<Type>asList(),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteCall<TransactionReceipt> signature(String url) {
        final Function function = new Function(
                FUNC_SIGNATURE,
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Utf8String(url)),
                Collections.<TypeReference<?>>emptyList()
        );
        return executeRemoteCallTransaction(function , new BigInteger("100"));
    }


    public RemoteCall<Bool> checkJsonDataCall(String json) {
        final Function function = new Function(
                FUNC_CHECKJSONDATA,
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Utf8String(json)),
                Arrays.asList(
                        new TypeReference<Bool>() {}
                )
        );
        return executeRemoteCallSingleValueReturn(function);
    }

    public RemoteCall<TransactionReceipt> checkJsonData(String json) {
        final Function function = new Function(
                FUNC_CHECKJSONDATA,
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Utf8String(json)),
                Arrays.asList(
                        new TypeReference<Bool>() {}
                )
        );
        return executeRemoteCallTransaction(function);
    }

    public RemoteCall<Bool> checkJson(String json) {
        final Function function = new Function(
                FUNC_CHECKJSON,
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Utf8String(json)),
                Arrays.asList(
                        new TypeReference<Bool>() {}
                )
        );
        return executeRemoteCallSingleValueReturn(function);
    }



    public RemoteCall<Bool> examine() {
        final Function function = new Function(
                FUNC_EXAMINE,
                Arrays.<Type>asList(),
                Arrays.asList(
                        new TypeReference<Bool>() {}
                )        );
        return executeRemoteCallSingleValueReturn(function);
    }

    public RemoteCall<TransactionReceipt> onlyCode(String year) {
        final Function function = new Function(
                FUNC_ONLYCODE,
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Utf8String(year)),
                Arrays.asList(
                        new TypeReference<Utf8String>() {}
                )          );
        return executeRemoteCallTransaction(function);
    }


    public RemoteCall<Utf8String> onlyCodeCall(String year) {
        final Function function = new Function(
                FUNC_ONLYCODE,
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Utf8String(year)),
                Arrays.asList(
                        new TypeReference<Utf8String>() {}
                )          );
        return executeRemoteCallSingleValueReturn(function);
    }

    public RemoteCall<List<Type>> onlyCode2(String json) {
        final Function function = new Function(
                FUNC_ONLYCODE,
                Arrays.asList(
                        new org.web3j.abi.datatypes.Utf8String(json)
                ),
                Arrays.asList(
                        new TypeReference<Utf8String>() {}
                )          );
        return executeRemoteCallMultipleValueReturn(function);
    }

    @Deprecated
    public static Contracts_Hzwq_sol_Hzwq load(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        return new Contracts_Hzwq_sol_Hzwq(contractAddress, web3j, credentials, gasPrice, gasLimit);
    }

    @Deprecated
    public static Contracts_Hzwq_sol_Hzwq load(String contractAddress, Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        return new Contracts_Hzwq_sol_Hzwq(contractAddress, web3j, transactionManager, gasPrice, gasLimit);
    }

    public static Contracts_Hzwq_sol_Hzwq load(String contractAddress, Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        return new Contracts_Hzwq_sol_Hzwq(contractAddress, web3j, credentials, contractGasProvider);
    }

    public static Contracts_Hzwq_sol_Hzwq load(String contractAddress, Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return new Contracts_Hzwq_sol_Hzwq(contractAddress, web3j, transactionManager, contractGasProvider);
    }

}
