'use strict'

os = require 'os'
fs = require 'fs' 
path = require 'path' 
process.env.NODE_ENV = os.hostname()
Sequelize = require 'sequelize' 
basename = path.basename(module.filename)
env = process.env.NODE_ENV or 'development'
config = require '../config/config'
#config = require(__dirname + '/../config/config.json')


db = {}

if process.env.HEROKU_POSTGRESQL_BRONZE_URL
	match = process.env.HEROKU_POSTGRESQL_BRONZE_URL.match(/postgres:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)/)

	console.log "using heroku settings"
	sequelize = new Sequelize config['Heroku'],
		dialect: "postgres"
		protocol: "postgres"
		port: match[4]
		host: match[3]
		loggin: true
		use_env_variable: "DATABASE_URL"
		
	
if config[env] != undefined
	console.log "using custom env settings"
	sequelize = new Sequelize config[env]

else 
	console.log "using development settings"
	sequelize = new Sequelize config['development']


fs.readdirSync(__dirname).filter( (file)->
	file.indexOf('.') != 0 and file != basename and file.slice(-7) == '.coffee'
).forEach (file)->
	model = sequelize['import'](path.join(__dirname, file))
	db[model.name] = model 
	return

Object.keys(db).forEach (modelName)->
	if db[modelName].associate
		db[modelName].associate db
	return

db.sequelize = sequelize
db.Sequelize = Sequelize
module.exports = db

