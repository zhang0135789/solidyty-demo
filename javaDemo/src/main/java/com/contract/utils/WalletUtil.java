package com.contract.utils;

import com.google.common.collect.ImmutableList;
import org.bitcoinj.crypto.*;
import org.web3j.crypto.Credentials;
import org.web3j.crypto.ECKeyPair;

import java.util.Arrays;

/**
 * @Author: zz
 * @Description:
 * @Date: 2:06 PM 10/10/20
 * @Modified By
 */
public class WalletUtil {

    /**
     * path路径
     */
    private final static ImmutableList<ChildNumber> BIP44_ETH_ACCOUNT_ZERO_PATH =
            ImmutableList.of(new ChildNumber(44, true), new ChildNumber(60, true),
                    ChildNumber.ZERO_HARDENED, ChildNumber.ZERO);


    public static Credentials getCredentials(String mnemonic) {
        String[] str = mnemonic.split(" ");

        byte[] seed = MnemonicCode.toSeed(Arrays.asList(str), "");
        DeterministicKey masterPrivateKey = HDKeyDerivation.createMasterPrivateKey(seed);
        DeterministicHierarchy deterministicHierarchy = new DeterministicHierarchy(masterPrivateKey);
        DeterministicKey deterministicKey = deterministicHierarchy
                .deriveChild(BIP44_ETH_ACCOUNT_ZERO_PATH, false, true, new ChildNumber(0));
        byte[] bytes = deterministicKey.getPrivKeyBytes();
        ECKeyPair keyPair = ECKeyPair.create(bytes);

        return Credentials.create(keyPair);

    }
}
