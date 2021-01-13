module.exports = {

  //默认coinbase是银行账户
  bankLogin: function (ScoreInstance, account) {
    const address = document.getElementById('bankLoginAddr').value
    ScoreInstance.getOwner({ from: account }).then(function (result) {
      if (address.localeCompare(result) === 0) {
        // 跳转到管理员页面
        window.location.href = 'bank.html?account=' + address
      } else {
        window.alert('不是银行账户，登录失败')
      }
    })
  },
  // 银行向顾客发送积分
  sendScoreToCustomer: function (ScoreInstance, account) {
    const address = document.getElementById('customerAddress').value
    const score = document.getElementById('scoreAmount').value
    console.log(address + "   " + score )
    ScoreInstance.sendScoreToCustomer(address, score, { from: account }).then(function(r){
      console.log(r)
      if (r) {
        console.log(r.logs[0].args.message)
        window.App.setStatus(r.logs[0].args.message)
      }
    })
    // ScoreInstance.SendScoreToCustomer(function (e, r) {
    //   if (!e) {
    //     console.log(r.args.message)
    //     window.App.setStatus(r.args.message)
    //   }
    // })
  },
  // 银行获取已经发行的积分
  getIssuedScoreAmount: function (ScoreInstance, account) {
    ScoreInstance.getIssuedScoreAmount({ from: account }).then(function (result) {
      window.App.setStatus('已发行的积分总数为：' + result)
    })
  },
  // 银行获得已经清算的积分
  getSettledScoreAmount: function (ScoreInstance, account) {
    ScoreInstance.getSettledScoreAmount({ from: account }).then(function (result) {
      window.App.setStatus('已清算的积分总数为：' + result)
    })
  }
}
