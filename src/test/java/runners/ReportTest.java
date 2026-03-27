package runners;

import org.apache.commons.io.FileUtils;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import org.junit.jupiter.api.Test;


import java.io.File;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import java.util.*;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ReportTest {
    @Test
    void comprehensiveReporting() {
        Results results = Runner.path("classpath:features/pet.feature")
                .outputJunitXml(true)          // For CI/CD
                .outputCucumberJson(true)      // For dashboards
                .outputHtmlReport(true)        // For debugging (default)
                .reportDir("target/ci-reports")
                .parallel(8);

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    public static void generateReport(String karateOutPath) {
        Collection<File> jsonFiles = FileUtils.listFiles (new File(karateOutPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("build"), "demo-qa-karate");

        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();


    }
}
