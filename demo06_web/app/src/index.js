
//导入CSS
import "./stylesheets/index.css";
//导入web3和truffle-contract库
import Web3 from "web3";
import { default as contract } from 'truffle-contract'

//导入Hello合约的ABI文件
import Hello_artifacts from '../../build/contracts/Hello.json'


//获取Hello合约对象
var HelloContract = contract(Hello_artifacts);

window.App = {
  init: function() {
    //设置web3连接
    HelloContract.setProvider(web3.currentProvider);
  },

  //封装合约中的say()方法调用过程，供javascript调用
  say: function(name, callback){
    //instance为Hello合约部署实例
    HelloContract.deployed().then(function(instance){
      //调用Hello合约中的say()方法，并传入参数name
      instance.say.call(name).then(function(result){
        //将返回结果传入回调函数
        callback(null, result);
      });
    }).catch(function(e){
      console.log(e, null);
    });
  }
};

window.addEventListener('load', function() {
  //设置web3连接  http://127.0.0.1:8545 为Ganache提供的节点链接
  window.web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:8545"));
  App.init();
});
