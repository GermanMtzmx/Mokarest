![mokaLogo](https://github.com/GermanMtzmx/Mokarest/blob/master/moka.png)


__Mokarest__ is a [coffeescript] flavor POC to develop restfull endpoints, runs on top of express js, moka is not intended to be a framework, was made to be a basement to develop any [nodejs] proyect.

By the moment only has jwt auth, public and private routing, database connection ( sequelize js)


##### Try it ! 

* Install node js in your pc, clone the repo and install dependencies (npm install)
* Install [Nodeenv] and create a virtual environment, install dependences and run it (only linux tested yet)

##### Run it !

Just type nmp run start


##### Npm commands
    npm run start (to start app)
    npm syncdb (to sync db - warning drop db)


##### Endpoints 

    localhost:3000/api/v1/public/users/signin (post)
    localhost:3000/api/v1/public/users/signup (post)
    localhost:3000/api/v1/public/users/profile (get - auth required)
    localhost:3000/api/v1/public/users/profile (put - auth required)


By default if sequelize doesnt detect your hostname in the db configuration , will take development settings (sqlite)

##### To set a custom db configuration :
> 1. Open the config.coffee file under config folder
> 2. Add a new item in the config dictionary (must name it like your hostname)
> 3. Set the sequelize js required options (dialect,name,host,password,username and timezone)

    MyHostname:
        dialect:"postgres"
        host:"localhost"
        name:"mycustomdb"
        username:"dbadmin"
        password:"s3cr3t"
        timezone:"UTC"


##### Creating models
Check [SequelizeJS] documentation


##### Creating controllers

> 1. Create a new controller with coffee extension under "controllers" folder
> 2. Import index models
> 3. Import status module (taken from django restframework proyect)
> 4. Create any class
> 5. Export it

__Example:__


    model = require '../models'
    status = require '../utils/status'
    
    class ExampleClass
        examplemethod: (req,res)->
            return res.status(status.HTTP_200_OK).send('ok response')
    class AuthClassRequired
        authorizedMethod: (req,res)->
            return res.status(status.HTTP_200_OK).send('ok private res')
    
    module.exports = 
        public:
            epublic:ExampleClass
        private:
            authclassreq:AuthClassRequired
    
	



##### Routing

To create urls for your controllers you must create a new coffee file under "routes" folder

> 1. Import express
> 2. Create an instance of express 
> 3. Import your desired controller
> 4. Instanciate any controller's class , (see controller module exporting above)
> 5. Create two instances of express router 
> 6. Create your routes 
> 7. Export it

__Example:__

    controller = require  '../controllers/myDesiredController'
    app = require 'express'
    publicUrls = express.Router()
    privateUrls = express.Router() 
    
    pubmethod = new.controller.public.epublic
    privmethod = new.controller.private.authclassreq
    
    publicUrls.route '/publicexample'
        .get pubmethod.examplemethod
    
    privateUrls.route '/privexample'
        .get privmethod. authorizedMethod
    
    module.exports = 
        public: publicUrls
        private:privateUrls
    
    

##### Finally import in the main  routing file (index)
index routing file is under "routes" folder

> 1. Import your urls 
> 2. Set a base for your custom urls (private and public urls )

###### Example

    myCustomUrls = require "../routes/customurls"
	publicroutes.use "/customUrlbase", myCustomUrls.public
	privateroutes.use "/anotherUrlBase", myCustomUrls.private
			


	
	
This proyect is under [BSD] License

[SequelizeJS]:http://docs.sequelizejs.com/en/v3/
[Nodeenv]:https://github.com/ekalinin/nodeenv
[coffeescript]:http://coffeescript.org/
[nodejs]:https://nodejs.org
[BSD]:https://raw.githubusercontent.com/GermanMtzmx/restfullCoffeeScript/master/LICENSE?token=ANl52DepDiIe8eBgaUn7tp2NR7PHRht4ks5YnrPxwA%3D%3D




