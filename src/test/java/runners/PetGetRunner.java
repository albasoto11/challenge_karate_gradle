package runners;

import com.intuit.karate.junit5.Karate;

class PetGetRunner {

    @Karate.Test
    Karate testPet() {
        return Karate.run("classpath:features/pet.feature");
    }
}