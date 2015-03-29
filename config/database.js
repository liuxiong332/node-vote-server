var _ = require('lodash');
var userInfo = JSON.parse(require('fs').readFileSync('./user.json', {'encoding': 'utf8'}));

var userConfig = {
  user:     userInfo.user,
  password: userInfo.password,
  options: {
    dialect: "mysql",
    port:    3306
  }
};

exports.DBConfig = {
  development: {
    dbName:   "vote",
  },
  test: {
    dbName:   "my_app_test",
  }
};

_.forIn(exports.DBConfig, function(value) {
  _.extend(value, userConfig);
});
