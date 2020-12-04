package com.contract.demo05;

import com.contract.common.BlockChainConfig;
import com.contract.utils.WalletUtil;
import com.my.contract.Contracts_Hzwq_sol_Hzwq;
import org.web3j.abi.FunctionEncoder;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.Bool;
import org.web3j.abi.datatypes.Function;
import org.web3j.abi.datatypes.Type;
import org.web3j.crypto.Credentials;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.methods.request.Transaction;
import org.web3j.protocol.core.methods.response.TransactionReceipt;
import org.web3j.protocol.http.HttpService;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.List;

/**
 * @Author: zz
 * @Description:
 * @Date: 6:26 PM 11/24/20
 * @Modified By
 */
public class Main2 {

    public static void main(String[] args) throws Exception {

        Web3j web3j = Web3j.build(new HttpService("http://127.0.0.1:8545"));
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
//        Boolean examineResult = hzwqContract.examine().send().getValue();

//        String year = "asdfgf";
//        String hash = hzwqContract.onlyCode(year).send().getBlockHash();
//        String onlyCode = hzwqContract.onlyCodeCall(year).send().getValue();

        String json = "{\"harmonic_meas_falg\":\"0\",\"latest_chk_date\":1592662706000,\"comm_identification\":\"01\",\"equip_code\":\"8000000020002345\",\"poweroff_mr_flag\":\"1\",\"area_code\":\"41101\",\"wh_area_id\":1842669077,\"demand_meter_flag\":\"1\",\"doc_creator_no\":\"ZHANGSHILIN7\",\"baudrate_code\":\"3\",\"hard_ver\":\"2\",\"org_type\":\"02\",\"rcv_id\":8000000020016359,\"ap_pre_level_code\":\"05\",\"con_mode\":\"02\",\"super_power_flag\":\"1\",\"type_code\":\"28\",\"made_date\":1591545600000,\"register_mode\":\"03\",\"chip_model_code\":\"9001\",\"pulse_sort_code\":\"1\",\"pulse_amplitude_code\":\"80ms\",\"comm_mode\":\"02\",\"const_code\":\"10\",\"elec_meas_disp_flag\":\"01\",\"comm_addr\":\"000046159513\",\"store_area_id\":1842669946,\"meter_digits\":\"6.2\",\"anti_phase_flag\":\"1\",\"made_no\":\"4130001000000461595133\",\"meter_id\":8000000078006450,\"freq_code\":\"01\",\"erp_batch_no\":\"500135011\",\"wh_id\":1727365119,\"both_way_calc\":\"1\",\"carrier_wave_id\":671502550,\"attachequip_type_code\":\"01\",\"contract_id\":8000000020010387,\"rp_pre_level_code\":\"02\",\"infrared_flag\":\"1\",\"meas_theory\":\"2\",\"last_test_date\":1592662706000,\"pr_code\":\"1\",\"overload_factor\":\"15\",\"new_flag\":\"01\",\"ts_digits\":\"009\",\"pr_org\":\"4110108\",\"vl_flag\":\"1\",\"wiring_mode\":\"2\",\"prepay_flag\":\"0\",\"rotate_cycle\":120,\"equip_code_new\":\"8000000020002345\",\"spec_code\":\"129\",\"rs485_route_qty\":2,\"cc_prevent_flag\":\"1\",\"lot_no\":\"2620060836801646\",\"load_curve_flag\":\"1\",\"redetects\":0,\"meter_usage\":\"00\",\"return_manu_flag\":\"01\",\"self_factor\":1,\"disp_mode\":\"01\",\"contract_no\":\"HA2019003924\",\"cl_flag\":\"1\",\"multirate_falg\":\"1\",\"store_loc_id\":1842671786,\"chip_manufacturer\":\"06\",\"remark\":\"5320063037002411\",\"rp_constant\":\"10\",\"rated_current\":\"00248\",\"ci\":\"02\",\"comm_prot_code\":\"20\",\"org_no\":\"414032\",\"doc_type_code\":\"02\",\"meter_close_mode\":\"03\",\"status_code\":\"006\",\"manufacturer\":\"00954\",\"equip_rate\":\"06\",\"volt_code\":\"04\",\"made_standard\":\"03\",\"inst_date\":1600393617000,\"data_status\":\"01\",\"reading_type_code\":\"01\",\"bar_code\":\"4130001000000461595133\",\"sort_code\":\"10\",\"relay_joint\":\"03\",\"asset_no\":\"4130001000000461595133\",\"belong_dept\":\"41403\",\"model_code\":\"05850\",\"bearing_struc\":\"06\",\"doc_create_date\":1591545600000,\"arrive_batch_no\":\"2620060836801646\"}";

        json = "asdasdasdasdasd";
        //        String checkJson = hzwqContract.checkJsonData(json).send().getBlockHash();
        Boolean checkJsonResult = hzwqContract.checkJsonDataCall(json).send().getValue();


//        Boolean checkJson = hzwqContract.checkJson(json).send().getValue();


        String url = "https://api.pro.coinbase.com/products/ETH-USD/ticker";
//        url = "http://192.168.29.30:8080/Demo/main?filePath=c.docx&certId=8000000000000063";
//        TransactionReceipt send = hzwqContract.signature(url).send();
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
