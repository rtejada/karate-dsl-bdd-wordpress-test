package helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator {

    public static String getRandomUsername(){

        Faker faker = new Faker();
        return faker.name().username() + faker.random().nextInt(0,100);
    }

    public static String getRandomName(){

        Faker faker = new Faker();
        return  faker.name().username();
    }

    public static String getRandomFirstName(){

        Faker faker = new Faker();
        return  faker.name().firstName();
    }

    public static String getRandomLastName(){

        Faker faker = new Faker();
        return  faker.name().lastName();
    }

    public static String getRandomPassword(){

        Faker faker = new Faker();
        return faker.business().creditCardNumber();

    }

    public static String getRandomEmail(){

        Faker faker = new Faker();
        return faker.name().firstName().toLowerCase() + faker.random().nextInt(0,100) + "@paradigm.com";

    }

    public static String toLowerCase(String value){
        value = value.replace(".", "-");
        return value.toLowerCase();

    }

    public static JSONObject getRandomArticleValues(){
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        return json;

    }

    public static String getRandomDescription(){

        Faker faker = new Faker();
        return faker.address().country();

    }
}
