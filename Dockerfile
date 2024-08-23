# Use an official OpenJDK image as the base
FROM openjdk:17-jdk

# Set environment variables for Maven
ENV MAVEN_VERSION=3.8.6 \
    MAVEN_HOME=/usr/share/maven \
    PATH=$MAVEN_HOME/bin:$PATH

# Install Maven
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xz -C /usr/share && \
    mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
    apt-get clean

# Set the working directory inside the container
WORKDIR /app

# Copy the local code to the container
COPY . .

# Run Maven to package the application (adjust the command as needed)
RUN mvn clean package

# Default command to run the application (adjust this as per your app)
CMD ["java", "-jar", "target/your-app.jar"]

