#Heroku 

config = 
	
	#development settings
	development:
		dialect:"sqlite"
		storage:"db.sqlite"



	#personal
	MrRobot:
		dialect: "postgres"
		username: "roboroot"
		database: "mr_robot_db"
		password: "secret"
		host: "127.0.0.1"
		timezone: "UTC"


module.exports =  config

