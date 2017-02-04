express = require 'express'
status = require '../utils/status'
publicroutes = express()
privateroutes = express()
router = express.Router()

#Import routes here

userurls = require '../routes/userurls'

# end import routes


publicroutes.use '/users',userurls.public
privateroutes.use '/users',userurls.private

module.exports =
	public:publicroutes
	private:privateroutes
	

