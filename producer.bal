//PRODUCER
import ballerina/log;
import ballerina/http;
import ballerina/kafka;
import wso2/gateway;


public function main() {

}
kafka:ProducerConfig producerConfigs ={
    bootstrapServers: "localhost:9092, localhost:9092" //producer localhost,
    clientId: "students",
    acks: "all",
    retryCount: 3
}

kafka:Producer kafkaProducer = new (producerConfigs);

public type APIGatewayListener object {
   public {
       EndpointConfiguration config;
       http:Listener httpListener;
   }

   new () {
       httpListener = new;
   }

};

// Create SQL client for MySQL database
endpoint h2:Client testDB {
    path: config:getAsString("DATABASE_PATH", default = "./h2-client"),
    name: config:getAsString("DATABASE_PATH", default = "testdb"),
    username: config:getAsString("DATABASE_USER", default = "SA"),
    password: config:getAsString("DATABASE_PASS", default = ""),
    poolOptions: { maximumPoolSize: 5 }
};

@docker:Config{
    name: "postgraduateProcess"
    tag: "V4.3"
}
@docker:Expose{}

@kubernetes:Ingress {
   hostname: "",
   name: "",
   path: "/"
}

@kubernetes:Service {
   serviceType: "NodePort",
   name: ""
}

@kubernetes:Deployment {
   image: "",
   baseImage: "",
   name: "",
   copyFiles: [{ target: "",
               source: <path_to_JDBC_jar> }]
}

@http:ServiceConfig{
    basePath: "/addNew"
}
