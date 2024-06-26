# Follow these instructions carefully to debug your issues

basic notes:
1. package our jar files (update pom with needed files in the maven pluggins): mvn clean package -DskipTests
2. create our docker image: docker build -t=vinsdocker/selenium .
3. launch and run containers: docker-compose up

- Ensure that you completely replace your pom dependencies with [this](../03-automation-framework/dependencies.md).
- Compare your project with mine.
  - [This](./selenium-docker/) is my project. 
  - Use tools like [WinMerge](https://winmerge.org/?lang=en) which can spot the difference between your project and my project.
- Run your test runs via IDE. It should work.
- Issue this command. `mvn clean package -DskipTests`. You should see `docker-resources` under `target`.
- `docker-resources` should contain following directories. Ensure that files are present under these directories.
  - config
  - libs
  - test-data
  - test-suites
- Go to `docker-resources` via command line. Then issue this command. One of them should work.
  - `java -cp 'libs/*' org.testng.TestNG test-suites/flight-reservation.xml`
  - `java -cp libs/* org.testng.TestNG test-suites/flight-reservation.xml`
  - `java -cp "libs/*" org.testng.TestNG test-suites/flight-reservation.xml`
- Windows Users
  - Try in PS
  - Try in regular command prompt. (`cmd`)
- Mac/Linux Users
  - Try via `bash`