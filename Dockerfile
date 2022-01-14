FROM maven:3-openjdk-8 as builder

WORKDIR /app

COPY . .

RUN mvn package

FROM anapsix/alpine-java

COPY --from=builder /app/target/budgetapp.jar /app/budgetapp.jar

COPY --from=builder /app/config/config.yml /app/config.yml

WORKDIR /app

CMD ["java", "-jar", "budgetapp.jar", "server", "config.yml"]

EXPOSE 8080
