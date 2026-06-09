#!/bin/bash

set -e

sudo apt update

sudo apt install -y openjdk-17-jdk wget unzip

sudo apt install -y gradle

if ! command -v gradle >/dev/null 2>&1; then

    GRADLE_VERSION="8.7"

    cd /tmp

    wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip

    sudo mkdir -p /opt/gradle

    sudo unzip -oq gradle-${GRADLE_VERSION}-bin.zip -d /opt/gradle

    if ! grep -q "/opt/gradle/gradle-${GRADLE_VERSION}/bin" ~/.bashrc; then
        echo "export PATH=/opt/gradle/gradle-${GRADLE_VERSION}/bin:\$PATH" >> ~/.bashrc
    fi

    export PATH=/opt/gradle/gradle-${GRADLE_VERSION}/bin:$PATH
fi

mkdir -p ~/devops/program3

cd ~/devops/program3

PROJECT="HelloGradle"

mkdir -p ${PROJECT}/src/main/java/com/example
mkdir -p ${PROJECT}/src/test/java/com/example

cd ${PROJECT}

cat > settings.gradle << 'EOF'
rootProject.name = 'HelloGradle'
EOF

cat > build.gradle << 'EOF'
plugins {
    id 'java'
    id 'application'
}

group = 'com.example'
version = '1.0'

repositories {
    mavenCentral()
}

dependencies {
    testImplementation 'junit:junit:4.13.2'
}

application {
    mainClass = 'com.example.App'
}

task hello {
    doLast {
        println 'Hello, Gradle!'
    }
}
EOF

cat > src/main/java/com/example/App.java << 'EOF'
package com.example;

public class App {
    public static void main(String[] args) {
        System.out.println("Hello World!");
    }
}
EOF

cat > src/test/java/com/example/AppTest.java << 'EOF'
package com.example;

import org.junit.Test;
import static org.junit.Assert.assertTrue;

public class AppTest {

    @Test
    public void testApp() {
        assertTrue(true);
    }
}
EOF
