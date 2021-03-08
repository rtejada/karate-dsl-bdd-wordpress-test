Feature: test page wordpress

  Background:
    * url urlBase

  Scenario: get all users
    Given path 'users'
    When method get
    Then status 200
    And match each response contains {name: '#notnull'}


  Scenario Outline: create new user and confirm status code

    * def dataGenerator = Java.type('helpers.DataGenerator')

    * def randomUsername = dataGenerator.getRandomUsername()
    * def randomFirstName = dataGenerator.getRandomFirstName()
    * def randomLastName = dataGenerator.getRandomLastName()
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomPassword = dataGenerator.getRandomPassword()

    Given path 'users'
    And request
    """
      {
        'username':#(randomUsername),
        'first_name':#(randomFirstName),
        'last_name':#(randomLastName),
        'password': #(randomPassword),
        'email':#(randomEmail)
      }
    """
    When method Post
    Then status 201
    And match response.id == '#number'
    And match response.username == randomUsername
    And match response.name == randomFirstName + ' ' + randomLastName
    And match response.first_name == randomFirstName
    And match response.last_name == randomLastName
    And match response.email == randomEmail
    And match response.link == '#string'
    And match response.nickname == randomUsername
    And match response.locale == '#string'
    And match response.slug == dataGenerator.toLowerCase(randomUsername)
    And match response.roles == '#array'
    And match response.registered_date == "#string"
    * def matchDate = call read('classpath:helpers/timeValidator.js') response.registered_date
    And match matchDate == true
    And match response.capabilities ==
    """
      {
        "read": "#boolean",
        "level_0": "#boolean",
        "subscriber": "#boolean"
      }
    """
    And match response.extra_capabilities.subscriber == "#boolean"


    Given path 'users'
    And request
    """
      {
        'username':<username>,
        'password': <password>,
        'email':<email>
      }
    """
    When method Post
    Then status <status>
    And match response == <errorResponse>

    Examples:
      | username          | password          | email          | errorResponse                                                                                                                              | status|
      | #(randomUsername) | #(randomPassword) | #(randomEmail) | {"code":"existing_user_login","message":"Lo siento, \u00a1ese nombre de usuario ya existe!","data":null}                                   | 500   |
      | "lorem ipsum"     | #(randomPassword) | #(randomEmail) | {"code":"existing_user_email","message":"Lo siento, \u00a1esa direcci\u00f3n de correo electr\u00f3nico ya est\u00e1 en uso!","data":null} | 500   |
      |        null       | #(randomPassword) | #(randomEmail) | {"code":"rest_missing_callback_param","message":"Par\u00e1metro(s) que falta(n): username","data":{"status":400,"params":["username"]}}    | 400   |
      | #(randomUsername) | #(randomPassword) |    null        | {"code":"rest_missing_callback_param","message":"Par\u00e1metro(s) que falta(n): email","data":{"status":400,"params":["email"]}}          | 400   |
      | #(randomUsername) |      null         | #(randomEmail) | {"code":"rest_missing_callback_param","message":"Par\u00e1metro(s) que falta(n): password","data":{"status":400,"params":["password"]}}    | 400   |
      | #(randomUsername) | #(randomPassword) | lorem          | {"code":"rest_invalid_param","message":"Par\u00e1metro(s) no v\u00e1lido(s): email","data":{"status":400,"params":{"email":"Direcci\u00f3n de correo electr\u00f3nico no valida."}}} | 400   |


  Scenario: create, retry and delete a new user

    * def user = callonce read('classpath:helpers/createUser.feature')

    Given path 'users', user.id
    When method Get
    Then status 200
    And match response.id == user.id
    And match response.name == user.name
    And match response.link == "#string"
    And match response.description == user.description
    And match response.slug == user.slug
    And match response.avatar_urls ==
    """
       {
            "24": "#string",
            "48": "#string",
            "96": "#string"
       }
    """
    And match response.meta == "#array"

    Given path 'users', user.id
    And params { force: 1, reassign: 0 }
    When method Delete
    Then status 200
    And match response.deleted == true
    And match response.previous.id == user.id
    And match response.previous.username == user.username
    And match response.previous.name == user.name
    And match response.previous.first_name == user.first_name
    And match response.previous.last_name == user.last_name
    And match response.previous.email == user.email
    And match response.previous.description == user.description
    And match response.previous.link == '#string'
    And match response.previous.locale == '#string'
    And match response.previous.nickname == user.username
    And match response.previous.slug == user.slug

    Given path 'users', user.id
    When method Get
    Then status 404
    And match response ==
    """
    {
      "code": "rest_user_invalid_id",
      "message": "#string",
      "data": {
          "status": 404
      }
    }
    """
#https://github.com/intuit/karate#responseheaders
