Sequelize = require 'sequelize'

DBConfig = require('../config/database.js').DBConfig
config = if process.env.NODE_ENV is 'test' then DBConfig.test else DBConfig.development

sequelize = new Sequelize(config.dbName, config.user, config.password, config.config)

Vote = sequelize.define 'vote',
  stage: Sequelize.STRING,
  actionSubject: Sequelize.STRING,
  actionContent: Sequelize.STRING,
  actionPromotor: Sequelize.STRING,

Option = sequelize.define 'option',
  value: Sequelize.STRING

Receiver = sequelize.define 'receiver',
  value: Sequelize.STRING

Vote.hasMany(Option)
Option.belongsTo(Vote)

Vote.hasMany(Receiver)
Receiver.belongsTo(Vote)

sync = require('q').all([Vote.sync(), Option.sync(), Receiver.sync()])
