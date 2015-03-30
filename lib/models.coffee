Sequelize = require 'sequelize'

DBConfig = require('../config/database.js').DBConfig
config = if process.env.NODE_ENV is 'test' then DBConfig.test else DBConfig.development

sequelize = new Sequelize(config.dbName, config.user, config.password, config.config)

Vote = sequelize.define 'vote',
  stage: Sequelize.STRING
  actionSubject: Sequelize.STRING
  actionContent: Sequelize.STRING
  actionPromotor: Sequelize.STRING

Option = sequelize.define 'option',
  value: Sequelize.STRING

Receiver = sequelize.define 'receiver',
  email: Sequelize.STRING
  lastAction: Sequelize.STRING

Promotor = sequelize.define 'promotor',
  email: Sequelize.STRING
  lastAction: Sequelize.STRING

User = sequelize.define 'user',
  username: Sequelize.STRING
  password: Sequelize.STRING

Vote.hasMany(Option)
Option.belongsTo(Vote)

Option.hasMany(Receiver)
Receiver.belongsTo(Option)

Vote.hasMany(Receiver)
Receiver.belongsTo(Vote)

Vote.hasOne(Promotor)
Promotor.belongsTo(Vote)

User.hasMany(Receiver)
Receiver.belongsTo(User)

User.hasMany(Promotor)
Promotor.belongsTo(User)

# sync = require('q').all([Vote.sync(), Option.sync(), Receiver.sync()])
module.exports = {Vote, Receiver, Option}
