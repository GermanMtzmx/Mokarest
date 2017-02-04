express = require 'express'
usercontroller = require '../controllers/userController'
#user = new publicUserController
common = new usercontroller.public.common
me = new usercontroller.private.me

publicUrls = express.Router()
privateUrls = express.Router()

publicUrls.post "/signin",common.signin
publicUrls.post "/signup",common.signup


privateUrls.route '/profile' 
	.get(me.profile)
	.put(me.updateprofile)

module.exports = 
	public:publicUrls
	private:privateUrls

