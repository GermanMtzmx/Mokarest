models = require '../models/'
status = require '../utils/status'
createToken = require '../auth/createToken'
crypt = require 'bcrypt-nodejs'
error = require '../utils/error'



class publicUserController

	signin: (req,res)->

		console.log "body ",req.body

		models.Users.findOne( where:
			username:req.body.username).then (user)->
			
			if not user  or not req.body.password
				return res.status(status.HTTP_401_UNAUTHORIZED).send(error.auth.WRONG_USER) 
			

			compare_password = crypt.compareSync(req.body.password,user.password)
	
			if not compare_password
				return res.status(status.HTTP_401_UNAUTHORIZED).send(error.auth.WRONG_CREDENTIALS)
			
			data =
				username: user.dataValues.username
				token: createToken user.dataValues

			return res.status(status.HTTP_200_OK).send data
				
		
		, (err)->
			console.log "error",err
			return res.status(status.HTTP_400_BAD_REQUEST).send()


	signup: (req,res)->
				
		models.Users.create(req.body).then (user)->				
			return res.status(status.HTTP_201_CREATED).send(user.dataValues)
		, (err)->
			return res.status(status.HTTP_400_BAD_REQUEST).send(err.errors)
			

class privateUserController

	profile:(req,res)->

		return res.status(status.HTTP_200_OK).send(req.user)

	updateprofile:(req,res)->
		return res.status(status.HTTP_200_OK).send("Update profile")

#define clases here 



#module.exports = publicUserController

#Expor all classes
module.exports =
	public: 
		common:publicUserController
		
	private: 
		me:privateUserController


