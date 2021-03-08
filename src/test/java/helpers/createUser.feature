Feature: Create user

  Background:
    * url urlBase

    Scenario: create, retry and delete a new user

      * def dataGenerator = Java.type('helpers.DataGenerator')

      * def randomUsername = dataGenerator.getRandomUsername()
      * def randomFirstName = dataGenerator.getRandomFirstName()
      * def randomLastName = dataGenerator.getRandomLastName()
      * def randomEmail = dataGenerator.getRandomEmail()
      * def randomPassword = dataGenerator.getRandomPassword()
      * def randomDescription = dataGenerator.getRandomDescription()

      Given path 'users'
      And request
      """
            {
              'username':#(randomUsername),
              'first_name':#(randomFirstName),
              'last_name':#(randomLastName),
              'password': #(randomPassword),
              'email':#(randomEmail),
              'description': #(randomDescription)
            }
          """
      When method Post
      Then status 201

      * def matchDate = call read('classpath:helpers/timeValidator.js') response.registered_date
      And match matchDate == true
      * def id = response.id
      * def username = randomUsername
      * def name = randomFirstName + ' ' + randomLastName
      * def first_name = randomFirstName
      * def last_name = randomLastName
      * def description = randomDescription
      * def email = randomEmail
      * def nickname = randomUsername
      * def slug = dataGenerator.toLowerCase(randomUsername)
      * def resp = response
