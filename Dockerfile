# -------- Build Stage --------

FROM ubuntu:22.04   as  builder

# Install Java + Maven
RUN apt update && \
    apt install -y openjdk-17-jdk maven && \
    apt clean

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the application
RUN mvn clean package -DskipTests 


# -------- Run Stage --------
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
