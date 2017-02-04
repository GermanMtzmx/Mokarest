jwt = require 'jsonwebtoken'
cfg = require '../config/auth_config'
status = require '../utils/status'

auth = (req,res,next)->

	token = req.headers.authorization
	

	if token 
		jwt.verify token, cfg.jwtSecret, (err,decoded)->
			if err
				return res.status(status.HTTP_401_UNAUTHORIZED).send({'error':'unauthorized'})
			else
				req.user = decoded						
				next()

			return

	else
		return res.status(status.HTTP_401_UNAUTHORIZED).send({'error':'unauthorized'})



module.exports = auth 