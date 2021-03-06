express  = require "express"
path = require "path"
bodyParser = require "body-parser"
logger = require "morgan"
routes = require './routes/index'
authmiddleware = require './auth/auth'
favicon = require 'serve-favicon'
router = express.Router()
status = require './utils/status'

app = express()
app.use logger 'dev'
app.use bodyParser.json()
app.use bodyParser.urlencoded
	extended: false

app.use favicon(__dirname + '/coffee.ico')


app.get '/', (req,res)->
	return res.status(status.HTTP_200_OK).send('Mokarest v-0.1')

app.use '/api/v1/public',routes.public

app.use '/api/v1/private',authmiddleware,routes.private


#Error handling

app.use (err,req,res,next)->
	res.status err.status or 500
	res.send 'error',
		message:err.message
		error:err
	return res
		
module.exports = app