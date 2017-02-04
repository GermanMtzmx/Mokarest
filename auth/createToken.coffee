jwt = require 'jsonwebtoken'
cfg = require '../config/auth_config'




createToken = (user)->
	token = jwt.sign({'id': user}, cfg.jwtSecret,{expiresIn:'3h'})
	return token

module.exports = createToken
