var account = require('./modules/account');

account.admin_get_account_by_limit({amount: '100', offset: '0'},(test)=>{
    console.log(test);
});