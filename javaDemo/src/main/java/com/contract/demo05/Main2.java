package com.contract.demo05;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.contract.common.BlockChainConfig;
import com.contract.utils.WalletUtil;
import com.my.contract.Contracts_Hzwq_sol_Hzwq;
import org.web3j.abi.FunctionEncoder;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.Bool;
import org.web3j.abi.datatypes.Function;
import org.web3j.abi.datatypes.Type;
import org.web3j.abi.datatypes.Uint;
import org.web3j.crypto.Credentials;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.methods.request.Transaction;
import org.web3j.protocol.core.methods.response.TransactionReceipt;
import org.web3j.protocol.http.HttpService;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author: zz
 * @Description:
 * @Date: 6:26 PM 11/24/20
 * @Modified By
 */
public class Main2 {

    public static void main(String[] args) throws Exception {

//        Web3j web3j = Web3j.build(new HttpService("http://127.0.0.1:8545"));
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
//        Boolean examineResult = hzwqContract.examine().send().getValue();

//        String year = "asdfgf";
////        String hash = hzwqContract.onlyCode(year , new BigInteger("1")).send().getBlockHash();
////        String onlyCode = hzwqContract.onlyCodeCall(year).send().getValue();
//
//        String json = "{\"harmonic_meas_falg\":\"0\",\"latest_chk_date\":1592662706000,\"comm_identification\":\"01\",\"equip_code\":\"8000000020002345\",\"poweroff_mr_flag\":\"1\",\"area_code\":\"41101\",\"wh_area_id\":1842669077,\"demand_meter_flag\":\"1\",\"doc_creator_no\":\"ZHANGSHILIN7\",\"baudrate_code\":\"3\",\"hard_ver\":\"2\",\"org_type\":\"02\",\"rcv_id\":8000000020016359,\"ap_pre_level_code\":\"05\",\"con_mode\":\"02\",\"super_power_flag\":\"1\",\"type_code\":\"28\",\"made_date\":1591545600000,\"register_mode\":\"03\",\"chip_model_code\":\"9001\",\"pulse_sort_code\":\"1\",\"pulse_amplitude_code\":\"80ms\",\"comm_mode\":\"02\",\"const_code\":\"10\",\"elec_meas_disp_flag\":\"01\",\"comm_addr\":\"000046159513\",\"store_area_id\":1842669946,\"meter_digits\":\"6.2\",\"anti_phase_flag\":\"1\",\"made_no\":\"4130001000000461595133\",\"meter_id\":8000000078006450,\"freq_code\":\"01\",\"erp_batch_no\":\"500135011\",\"wh_id\":1727365119,\"both_way_calc\":\"1\",\"carrier_wave_id\":671502550,\"attachequip_type_code\":\"01\",\"contract_id\":8000000020010387,\"rp_pre_level_code\":\"02\",\"infrared_flag\":\"1\",\"meas_theory\":\"2\",\"last_test_date\":1592662706000,\"pr_code\":\"1\",\"overload_factor\":\"15\",\"new_flag\":\"01\",\"ts_digits\":\"009\",\"pr_org\":\"4110108\",\"vl_flag\":\"1\",\"wiring_mode\":\"2\",\"prepay_flag\":\"0\",\"rotate_cycle\":120,\"equip_code_new\":\"8000000020002345\",\"spec_code\":\"129\",\"rs485_route_qty\":2,\"cc_prevent_flag\":\"1\",\"lot_no\":\"2620060836801646\",\"load_curve_flag\":\"1\",\"redetects\":0,\"meter_usage\":\"00\",\"return_manu_flag\":\"01\",\"self_factor\":1,\"disp_mode\":\"01\",\"contract_no\":\"HA2019003924\",\"cl_flag\":\"1\",\"multirate_falg\":\"1\",\"store_loc_id\":1842671786,\"chip_manufacturer\":\"06\",\"remark\":\"5320063037002411\",\"rp_constant\":\"10\",\"rated_current\":\"00248\",\"ci\":\"02\",\"comm_prot_code\":\"20\",\"org_no\":\"414032\",\"doc_type_code\":\"02\",\"meter_close_mode\":\"03\",\"status_code\":\"006\",\"manufacturer\":\"00954\",\"equip_rate\":\"06\",\"volt_code\":\"04\",\"made_standard\":\"03\",\"inst_date\":1600393617000,\"data_status\":\"01\",\"reading_type_code\":\"01\",\"bar_code\":\"4130001000000461595133\",\"sort_code\":\"10\",\"relay_joint\":\"03\",\"asset_no\":\"4130001000000461595133\",\"belong_dept\":\"41403\",\"model_code\":\"05850\",\"bearing_struc\":\"06\",\"doc_create_date\":1591545600000,\"arrive_batch_no\":\"2620060836801646\"}";
//
//
//        json = "asdasdasdasdasd";
//        Boolean checkJson = hzwqContract.checkJson(json).send().getValue();
//        Boolean checkJsonResult = hzwqContract.checkJsonDataCall(json , new BigInteger("1")).send().getValue();
//
//
////        Boolean checkJson = hzwqContract.checkJson(json).send().getValue();
//
//
//        String onlyCodeHash = hzwqContract.onlyCode("JD2022" , new BigInteger("1")).send().getBlockHash();
//        String onlyCode = hzwqContract.onlyCodeCall("JD2002",new BigInteger("1")).send().getValue();
//
//
//        //审批合约测试
//        String jsonData = "{\n" +
//                "  \"equip_measuring_range\": \"200V\\n(0.1~100)A\",\n" +
//                "  \"starting_conc_code\": \"合格\",\n" +
//                "  \"creeping_conc_code\": \"合格\",\n" +
//                "  \"divice_expired_date\": \"2021-06-20\",\n" +
//                "  \"detect_task_no\": \"3920061836906517\",\n" +
//                "  \"divice_name\": \"单相交流电能表标准装置\",\n" +
//                "  \"con_mode\": \"直接接入\",\n" +
//                "  \"ap_pre_level_code\": \"1级\",\n" +
//                "  \"equip_accuracy\": \"0.1级\",\n" +
//                "  \"cert_no\": \"JL2020\",\n" +
//                "  \"equip_name\": \"单相交流电能表检定装置\",\n" +
//                "  \"equip_certificate_no\": \"JL2020字第005号\",\n" +
//                "  \"small_start\": \"2020-05-17\",\n" +
//                "  \"small_file_id\": \"标准器证数文件ID\",\n" +
//                "  \"expired_date\": \"2028年06月19日\",\n" +
//                "  \"const_code\": \"1200\",\n" +
//                "  \"small_no\": \"JL2020字第DJZ-278号\",\n" +
//                "  \"cert_code\": \"DD-062000001\",\n" +
//                "  \"const_conc_code\": \"合格\",\n" +
//                "  \"conclusion\": \"合格\",\n" +
//                "  \"line_loc\": \"2楼单相智能电能表流水线\",\n" +
//                "  \"big_file_id\": \"检测装置证书文件ID\",\n" +
//                "  \"verified_date\": \"2020年06月20日\",\n" +
//                "  \"big_start\": \"2017-06-21\",\n" +
//                "  \"unit_no\": \"0111\",\n" +
//                "  \"file_id\": \"cert8000000000000062\",\n" +
//                "  \"wiring_mode\": \"单相\",\n" +
//                "  \"volt_conc_code\": \"合格\",\n" +
//                "  \"big_end\": \"2021-06-20\",\n" +
//                "  \"cert_id\": \"8000000000000062\",\n" +
//                "  \"ap_level\": \"0.1级\",\n" +
//                "  \"cert_type\": \"单相交流电能表标准装置\",\n" +
//                "  \"detect_person\": {\n" +
//                "    \"staff_name\": \"任月敏\",\n" +
//                "    \"cert_type\": \"检定员证\",\n" +
//                "    \"gender\": \"1\",\n" +
//                "    \"profession_bgn_date\": \"2006-02-20 00:00:00.0\",\n" +
//                "    \"cert_release_date\": \"2006-02-20 00:00:00.0\",\n" +
//                "    \"birth_date\": \"1958-01-01 00:00:00.0\",\n" +
//                "    \"cert_id\": \"1000000000601135\",\n" +
//                "    \"remark\": \"\",\n" +
//                "    \"staff_no\": \"02665609\",\n" +
//                "    \"profession_code\": \"01\",\n" +
//                "    \"doc_create_date\": \"\",\n" +
//                "    \"staff_sort_code\": \"01\",\n" +
//                "    \"dept_no\": \"0000029500\",\n" +
//                "    \"titel\": \"02\",\n" +
//                "    \"pub_org_name\": \"国家电网公司计量办公室\",\n" +
//                "    \"pos_name\": \"\",\n" +
//                "    \"cert_level\": \"04\",\n" +
//                "    \"emp_no\": \"\",\n" +
//                "    \"staff_id\": \"1000000000001620\",\n" +
//                "    \"cert_valid_date\": \"2016-02-18 00:00:00.0\",\n" +
//                "    \"belong_org\": \"4110108\",\n" +
//                "    \"srv_level_code\": \"1\",\n" +
//                "    \"belong_org_name\": \"省电科院（计量中心）\",\n" +
//                "    \"org_no\": \"41412\",\n" +
//                "    \"org_name\": \"国网河南省电力公司\",\n" +
//                "    \"cert_remark\": \"\",\n" +
//                "    \"cert_file_id\": \"0007\",\n" +
//                "    \"cert_valid_flag\": \"03\",\n" +
//                "    \"org_sort_code\": \"02\",\n" +
//                "    \"cert_no\": \"国网计检电字第431001号\",\n" +
//                "    \"cert_sort_code\": \"01\",\n" +
//                "    \"dept_name\": \"计量中心\",\n" +
//                "    \"cert_pro_type\": \"01\",\n" +
//                "    \"work_type_code\": \"02\",\n" +
//                "    \"title_level_code\": \"\",\n" +
//                "    \"is_identifier\": \"01\",\n" +
//                "    \"degree_code\": \"02\",\n" +
//                "    \"cert_item\": \"\",\n" +
//                "    \"work_pos\": \"02\",\n" +
//                "    \"status\": \"\"\n" +
//                "  },\n" +
//                "  \"cert_error\": [\n" +
//                "    {\n" +
//                "      \"error_type\": \"1\",\n" +
//                "      \"bar_code\": \"4130001000000446529641\",\n" +
//                "      \"rated_current\": \"5(60)\",\n" +
//                "      \"int_convert_err\": \"0.0\",\n" +
//                "      \"pf\": \"0.5L\",\n" +
//                "      \"load_current\": \"Imax\",\n" +
//                "      \"iabc\": \"单相\",\n" +
//                "      \"cert_err_id\": \"8000000000003256\",\n" +
//                "      \"cert_id\": \"8000000000000062\",\n" +
//                "      \"volt_code\": \"220\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "      \"error_type\": \"1\",\n" +
//                "      \"bar_code\": \"4130001000000446529641\",\n" +
//                "      \"rated_current\": \"5(60)\",\n" +
//                "      \"int_convert_err\": \"0.0\",\n" +
//                "      \"pf\": \"1\",\n" +
//                "      \"load_current\": \"0.5Imax\",\n" +
//                "      \"iabc\": \"单相\",\n" +
//                "      \"cert_err_id\": \"8000000000003257\",\n" +
//                "      \"cert_id\": \"8000000000000062\",\n" +
//                "      \"volt_code\": \"220\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "      \"error_type\": \"1\",\n" +
//                "      \"bar_code\": \"4130001000000446529641\",\n" +
//                "      \"rated_current\": \"5(60)\",\n" +
//                "      \"int_convert_err\": \"0.0\",\n" +
//                "      \"pf\": \"0.5L\",\n" +
//                "      \"load_current\": \"0.5Imax\",\n" +
//                "      \"iabc\": \"单相\",\n" +
//                "      \"cert_err_id\": \"8000000000003258\",\n" +
//                "      \"cert_id\": \"8000000000000062\",\n" +
//                "      \"volt_code\": \"220\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "      \"error_type\": \"1\",\n" +
//                "      \"bar_code\": \"4130001000000446529641\",\n" +
//                "      \"rated_current\": \"5(60)\",\n" +
//                "      \"int_convert_err\": \"0.0\",\n" +
//                "      \"pf\": \"1\",\n" +
//                "      \"load_current\": \"Ib\",\n" +
//                "      \"iabc\": \"单相\",\n" +
//                "      \"cert_err_id\": \"8000000000003259\",\n" +
//                "      \"cert_id\": \"8000000000000062\",\n" +
//                "      \"volt_code\": \"220\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "      \"error_type\": \"1\",\n" +
//                "      \"bar_code\": \"4130001000000446529641\",\n" +
//                "      \"rated_current\": \"5(60)\",\n" +
//                "      \"int_convert_err\": \"0.0\",\n" +
//                "      \"pf\": \"0.5L\",\n" +
//                "      \"load_current\": \"Ib\",\n" +
//                "      \"iabc\": \"单相\",\n" +
//                "      \"cert_err_id\": \"8000000000003260\",\n" +
//                "      \"cert_id\": \"8000000000000062\",\n" +
//                "      \"volt_code\": \"220\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "      \"error_type\": \"1\",\n" +
//                "      \"bar_code\": \"4130001000000446529641\",\n" +
//                "      \"rated_current\": \"5(60)\",\n" +
//                "      \"int_convert_err\": \"0.0\",\n" +
//                "      \"pf\": \"0.5L\",\n" +
//                "      \"load_current\": \"0.2Ib\",\n" +
//                "      \"iabc\": \"单相\",\n" +
//                "      \"cert_err_id\": \"8000000000003261\",\n" +
//                "      \"cert_id\": \"8000000000000062\",\n" +
//                "      \"volt_code\": \"220\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "      \"error_type\": \"1\",\n" +
//                "      \"bar_code\": \"4130001000000446529641\",\n" +
//                "      \"rated_current\": \"5(60)\",\n" +
//                "      \"int_convert_err\": \"0.0\",\n" +
//                "      \"pf\": \"1\",\n" +
//                "      \"load_current\": \"0.1Ib\",\n" +
//                "      \"iabc\": \"单相\",\n" +
//                "      \"cert_err_id\": \"8000000000003262\",\n" +
//                "      \"cert_id\": \"8000000000000062\",\n" +
//                "      \"volt_code\": \"220\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "      \"error_type\": \"1\",\n" +
//                "      \"bar_code\": \"4130001000000446529641\",\n" +
//                "      \"rated_current\": \"5(60)\",\n" +
//                "      \"int_convert_err\": \"0.0\",\n" +
//                "      \"pf\": \"0.5L\",\n" +
//                "      \"load_current\": \"0.1Ib\",\n" +
//                "      \"iabc\": \"单相\",\n" +
//                "      \"cert_err_id\": \"8000000000003263\",\n" +
//                "      \"cert_id\": \"8000000000000062\",\n" +
//                "      \"volt_code\": \"220\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "      \"error_type\": \"1\",\n" +
//                "      \"bar_code\": \"4130001000000446529641\",\n" +
//                "      \"rated_current\": \"5(60)\",\n" +
//                "      \"int_convert_err\": \"0.0\",\n" +
//                "      \"pf\": \"1\",\n" +
//                "      \"load_current\": \"Imax\",\n" +
//                "      \"iabc\": \"单相\",\n" +
//                "      \"cert_err_id\": \"8000000000003264\",\n" +
//                "      \"cert_id\": \"8000000000000062\",\n" +
//                "      \"volt_code\": \"220\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "      \"error_type\": \"1\",\n" +
//                "      \"bar_code\": \"4130001000000446529641\",\n" +
//                "      \"rated_current\": \"5(60)\",\n" +
//                "      \"int_convert_err\": \"0.0\",\n" +
//                "      \"pf\": \"1\",\n" +
//                "      \"load_current\": \"0.05Ib\",\n" +
//                "      \"iabc\": \"单相\",\n" +
//                "      \"cert_err_id\": \"8000000000003265\",\n" +
//                "      \"cert_id\": \"8000000000000062\",\n" +
//                "      \"volt_code\": \"220\"\n" +
//                "    }\n" +
//                "  ],\n" +
//                "  \"meter_range\": \"200V\\n(0.1~100)A\",\n" +
//                "  \"clock_conc\": \"合格\",\n" +
//                "  \"dayerr_conc_code\": \"0.00s/d\",\n" +
//                "  \"big_no\": \"[2017]豫量标电试证字第047号\",\n" +
//                "  \"freq\": \"50Hz\",\n" +
//                "  \"clock_error\": \"0\",\n" +
//                "  \"regulation\": \"JJG 596-2012 电子式交流电能表\",\n" +
//                "  \"rated_current\": \"5(60)A\",\n" +
//                "  \"humidity\": \"53\",\n" +
//                "  \"divice_certificate_no\": \"[2017]豫量标电试证字第047号\",\n" +
//                "  \"small_end\": \"2021-05-16\",\n" +
//                "  \"org_no\": \"国网河南省电力公司郑州供电公司\",\n" +
//                "  \"divice_accuracy\": \"0.1级\",\n" +
//                "  \"manufacturer\": \"华立科技股份有限公司\",\n" +
//                "  \"place\": \"国网河南省计量中心2楼单相智能电能表流水线\",\n" +
//                "  \"volt_code\": \"220V\",\n" +
//                "  \"sys_no\": \"200101\",\n" +
//                "  \"line_certno_id\": \"11\",\n" +
//                "  \"temperaure\": \"21.2\",\n" +
//                "  \"data_status\": \"01\",\n" +
//                "  \"mea_name\": \"单相费控智能电能表\",\n" +
//                "  \"bar_code\": \"4130001000000446529641\",\n" +
//                "  \"divice_measuring_range\": \"200V\\n(0.1~100)A\",\n" +
//                "  \"intuit_conc_code\": \"合格\",\n" +
//                "  \"model_code\": \"DDZY285-Z\",\n" +
//                "  \"mode_code\": \"AMT1796  E17011\",\n" +
//                "  \"equip_expired_date\": \"2021-05-16\",\n" +
//                "  \"T_CLOCK_VALUE_MET_CONC\": [\n" +
//                "    {\n" +
//                "      \"MET_VALUE\": \"12:23:59\",\n" +
//                "      \"STD_VALUE\": \"12:23:58\",\n" +
//                "      \"TIME_ERR\": \"1\"\n" +
//                "    }\n" +
//                "  ],\n" +
//                "  \"T_BASICERR_MET_CONC\": [\n" +
//                "    {\n" +
//                "      \"read_id\": 8000000720886249,\n" +
//                "      \"equip_id\": 8000000078515178,\n" +
//                "      \"detect_task_no\": \"2120072037292435\",\n" +
//                "      \"equip_categ\": \"01\",\n" +
//                "      \"sys_no\": \"200201\",\n" +
//                "      \"detect_equip_no\": \"208016\",\n" +
//                "      \"detect_unit_no\": \"01\",\n" +
//                "      \"position_no\": \"11\",\n" +
//                "      \"bar_code\": \"4130001000000461395474\",\n" +
//                "      \"detect_date\": \"2020-07-20 22:56:38\",\n" +
//                "      \"para_index\": \"5\",\n" +
//                "      \"detect_item_point\": \"3\",\n" +
//                "      \"is_valid\": \"1\",\n" +
//                "      \"both_way_power_flag\": \"0\",\n" +
//                "      \"iabc\": \"01\",\n" +
//                "      \"load_current\": \"Imax\",\n" +
//                "      \"load_voltage\": \"04\",\n" +
//                "      \"freq\": \"01\",\n" +
//                "      \"pf\": \"1\",\n" +
//                "      \"detect_circle\": \"1\",\n" +
//                "      \"simpling\": \"2\",\n" +
//                "      \"error\": \"+0.0389|+0.0389\",\n" +
//                "      \"ave_err\": \"+0.0389\",\n" +
//                "      \"int_convert_err\": \"0.0\",\n" +
//                "      \"chk_conc_code\": \"01\",\n" +
//                "      \"org_no\": \"4110108\",\n" +
//                "      \"area_code\": \"41101\",\n" +
//                "      \"err_up\": \"+0.6\",\n" +
//                "      \"err_down\": \"-0.6\"\n" +
//                "    },\n" +
//                "    {\n" +
//                "      \"read_id\": 8000000720886225,\n" +
//                "      \"equip_id\": 8000000078515178,\n" +
//                "      \"detect_task_no\": \"2120072037292435\",\n" +
//                "      \"equip_categ\": \"01\",\n" +
//                "      \"sys_no\": \"200201\",\n" +
//                "      \"detect_equip_no\": \"208016\",\n" +
//                "      \"detect_unit_no\": \"01\",\n" +
//                "      \"position_no\": \"11\",\n" +
//                "      \"bar_code\": \"4130001000000461395474\",\n" +
//                "      \"detect_date\": \"2020-07-20 22:56:40\",\n" +
//                "      \"para_index\": \"5\",\n" +
//                "      \"detect_item_point\": \"29\",\n" +
//                "      \"is_valid\": \"1\",\n" +
//                "      \"both_way_power_flag\": \"0\",\n" +
//                "      \"iabc\": \"05\",\n" +
//                "      \"load_current\": \"00\",\n" +
//                "      \"load_voltage\": \"04\",\n" +
//                "      \"freq\": \"01\",\n" +
//                "      \"pf\": \"07\",\n" +
//                "      \"detect_circle\": \"1\",\n" +
//                "      \"simpling\": \"2\",\n" +
//                "      \"error\": \"-0.1691|-0.1719\",\n" +
//                "      \"ave_err\": \"-0.1705\",\n" +
//                "      \"int_convert_err\": \"-0.2\",\n" +
//                "      \"chk_conc_code\": \"01\",\n" +
//                "      \"org_no\": \"4110108\",\n" +
//                "      \"area_code\": \"41101\",\n" +
//                "      \"err_up\": \"+1.2\",\n" +
//                "      \"err_down\": \"-1.2\"\n" +
//                "    }\n" +
//                "  ],\n" +
//                "  \"t_basicerr_met_conc\": [\n" +
//                "    {\n" +
//                "      \"detect_task_no\": \"2120072037292435\",\n" +
//                "      \"bar_code\": \"4130001000000461409508\",\n" +
//                "      \"both_way_power_flag\": \"0\",\n" +
//                "      \"iabc\": \"01\",\n" +
//                "      \"load_current\": \"08\",\n" +
//                "      \"pf\": \"1\",\n" +
//                "      \"ave_err\": \"+0.2228\",\n" +
//                "      \"int_convert_err\": \"+0.2\",\n" +
//                "      \"chk_conc_code\": \"01\",\n" +
//                "      \"simpling\": \"12:23:58\",\n" +
//                "      \"error\": \"1\"\n" +
//                "    }\n" +
//                "  ],\n" +
//                "  \"t_clock_value_met_conc\": [\n" +
//                "    {\n" +
//                "      \" detect_task_no \": \"3920061836906517\",\n" +
//                "      \"bar_code\": \"\",\n" +
//                "      \"met_value\": \"12:23:59\",\n" +
//                "      \"std_value\": \"12:23:58\",\n" +
//                "      \"time_err\": \"1\"\n" +
//                "    }\n" +
//                "  ],\n" +
//                "  \"t_demandvalue_met_conc\": [\n" +
//                "    {\n" +
//                "      \"detect_task_no\": \"3920061836906517\",\n" +
//                "      \"bar_code\": \"\",\n" +
//                "      \"load_current\": \"\",\n" +
//                "      \"demand_standard\": \"\",\n" +
//                "      \"demand_meter\": \"\",\n" +
//                "      \"demand_value_err\": \"\"\n" +
//                "    }\n" +
//                "  ],\n" +
//                "  \"t_dayerr_met_conc\": [\n" +
//                "    {\n" +
//                "      \"detect_task_no\": \"3920061836906517\",\n" +
//                "      \"bar_code\": \"\",\n" +
//                "      \"simpling\": \"\",\n" +
//                "      \"error\": \"\",\n" +
//                "      \"avg_err\": \"\",\n" +
//                "      \"int_convert_err\": \"\"\n" +
//                "    }\n" +
//                "  ],\n" +
//                "  \"t_hutchison_combina_met_conc\": [\n" +
//                "    {\n" +
//                "      \"detect_task_no\": \"3920061836906517\",\n" +
//                "      \"bar_code\": \"4130001000000446529641\",\n" +
//                "      \"start_value\": \"0.30|0.30|0.00|0.00|0.00\",\n" +
//                "      \"end_value\": \"0.60|0.38|0.07|0.07|0.07\",\n" +
//                "      \"ele_increment\": \"0.300|0.080|0.070|0.070|0.070\",\n" +
//                "      \"value_conc_code\": \"0.00\"\n" +
//                "    }\n" +
//                "  ]\n" +
//                "}";
//
//        String hege = "合格";
//        //1
//        Object[] arr1 = hzwqContract.examine1(jsonData , hege, hege , hege , hege,hege,hege).send().toArray();
//
//        Boolean r1 = ((Bool)arr1[0]).getValue();
//        String r2 = arr1[1].toString();
//        BigInteger r3 = ((Uint)arr1[2]).getValue();
//
//        BigInteger dayerr_conc_code = new BigInteger("12");
//        BigInteger clock_error = new BigInteger("200");
//        BigInteger met_value = new BigInteger("22");
//        BigInteger std_value = new BigInteger("12");
//        BigInteger time_err = new BigInteger("10");
//
//        //2
//        Object[] arr2 = hzwqContract.examine2(dayerr_conc_code,clock_error,met_value,std_value,time_err,hege).send().toArray();
//
//
//
//
//        JSONObject baseJson = JSONObject.parseObject(jsonData);
//        int lenI = 13;
//        int lenJ = 8;
//        int size = lenI * lenJ;
//        String[] array1 = new String[size];
//        BigInteger[] array2 = new BigInteger[size];
//        JSONArray baseDataArr = baseJson.getJSONArray("t_basicerr_met_conc");
//
//
//
//        int a = 0;
//        int b = 0;
//        for(int x = 0 ; x < baseDataArr.size() ; x++ ) {
//            JSONObject baseData = baseDataArr.getJSONObject(x);
//            // 01合项 02A项 03B项 04C项
//            String iabc = baseData.getString("iabc");
//            //I
//            String loadCurrent = baseData.getString("load_current");
//            //P.F
//            String pf = baseData.getString("pf");
//
//            if("Imax".equals(loadCurrent)) {
//                a = 0;
//            }else if("0.5Imax".equals(loadCurrent)) {
//                a = 1;
//            }else if("In".equals(loadCurrent)) {
//                a = 2;
//            }else if("0.2In".equals(loadCurrent)) {
//                a = 3;
//            }else if("0.1In".equals(loadCurrent)) {
//                a = 4;
//            }else if("0.05In".equals(loadCurrent)) {
//                a = 5;
//            }else if("0.02In".equals(loadCurrent)) {
//                a = 6;
//            }else if("0.01In".equals(loadCurrent)) {
//                a = 7;
//            }
//
//            if("01".equals(iabc)) {
//                if("1".equals(pf)) {
//                    b = 0;
//                }else if("0.5L".equals(pf)) {
//                    b = 1;
//                }else if("0.8C".equals(pf)) {
//                    b = 2;
//                }else if("0.25L".equals(pf)) {
//                    b = 3;
//                }
//            }else if("02".equals(iabc)) {
//                if("1".equals(pf)) {
//                    b = 4;
//                }else if("0.5L".equals(pf)) {
//                    b = 5;
//                }else if("0.5C".equals(pf)) {
//                    b = 6;
//                }
//            }else if("03".equals(iabc)) {
//                if("1".equals(pf)) {
//                    b = 7;
//                }else if("0.5L".equals(pf)) {
//                    b = 8;
//                }else if("0.5C".equals(pf)) {
//                    b = 9;
//                }
//            }else if("04".equals(iabc)) {
//                if("1".equals(pf)) {
//                    b = 10;
//                }else if("0.5L".equals(pf)) {
//                    b = 11;
//                }else if("0.5C".equals(pf)) {
//                    b = 12;
//                }
//            }
//
//            array1[(a * 10) + b] = baseData.getString("bar_code");
//        }
//        for(int i = 0 ; i < array1.length ; i++) {
//            if(null == array1[i]) {
//                array1[i] = "";
//            }
//        }
//        for(int i = 0 ; i < array2.length ; i++) {
//            if(null == array2[i]) {
//                array2[i] = BigInteger.ZERO;
//            }
//        }

//        List<String> list1 = Arrays.asList(array1);

//        array1[1] = "1234567";
//        array2[0] = new BigInteger("12");
//        List<BigInteger> list2 = Arrays.asList(array2);

        //3

//        List<BigInteger> list2 = new ArrayList<>();
//         Object[] arr3 = hzwqContract.examine3(array1 , array2).send().toArray();


        String url = "https://api.pro.coinbase.com/products/ETH-USD/ticker";
        url = "http://3f57k37764.zicp.vip/SignFile/main?filePath=4130001000000461595133&certId=8000000000000065";
//        url = "http://192.168.29.30:8080/Demo/main?filePath=c.docx&certId=8000000000000063";
//        TransactionReceipt send = hzwqContract.updatePrice().send();
        TransactionReceipt send = hzwqContract.signature(url).send();

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
