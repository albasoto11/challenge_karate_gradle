plugins {
    id("java")
}

group = "org.challenge"
version = "1.0-SNAPSHOT"

java {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
}
repositories {
    mavenCentral()
}



dependencies {
    testImplementation(platform("org.junit:junit-bom:5.10.0"))
    testImplementation("com.intuit.karate:karate-junit5:1.4.1")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
    testImplementation("net.masterthought:cucumber-reporting:5.7.5")
    testImplementation("commons-io:commons-io:2.11.0")
}

tasks.test {
    useJUnitPlatform()
}

