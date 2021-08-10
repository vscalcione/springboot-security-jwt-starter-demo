FROM maven as maven-mantainer
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY pom.xml .
RUN mvn -B -f pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve
COPY . .
RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml package

FROM openjdk:8-alphine
RUN adduser -Dh /home/vscalcione vscalcione
WORKDIR /app
COPY --from=maven-container /usr/src/app/target/jwtstarterdemo-0.0.1-SNAPSHOT.war .
ENTRYPOINT [ "java", "-jar", "/app/jwtstarterdemo-0.0.1-SNAPSHOT.war"]
