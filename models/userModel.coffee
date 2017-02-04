crypt = require 'bcrypt-nodejs'

module.exports = (sequelize, DataTypes) ->
  Users = sequelize.define('Users', {
    uuid:
      primaryKey:true
      type:DataTypes.UUID
      defaultValue: DataTypes.UUIDV4
    name: 
      type:DataTypes.STRING
      allowNull:false
      validate:
        is: /^[A-Za-z\u00C0-\u017F\s]*$/
        len:[3,20]
        
    lastname: 
      type:DataTypes.STRING
      allowNull:false

      validate:
        
        is:/^[A-Za-z\u00C0-\u017F\s]*$/
        len:[4,30]

    email:
      allowNull:false
      type:DataTypes.STRING
      validate:
        isEmail:true
        


    username: 
      type:DataTypes.STRING
      allowNull:false      
      validate:
        len:[4,20]
        
        is:/^[a-zA-Z\s\-\_0-9]*$/
    
    password: 
      type:DataTypes.STRING      
      allowNull:false
      validate:
        len:[6,12]
        
    # role: 
    #   type:DataTypes.STRING
    #   validate:
    #     isIn:[["admin","boss","supervisor","employee"]]
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )

  Users.beforeCreate (user,options)->
    if user.password
      encrypted = crypt.hashSync(user.password)
      user.password = encrypted
      return user.password

  Users.beforeUpdate (user,options)->

    isEncrypt = user.password.indexOf "$2$"
    if isEncrypt < 0
      encrypted = crypt.hashSync(user.password)
      user.password = encrypted
      return user.password



  
  