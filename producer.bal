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

enum Users {
  students,
  supervisors,
  HOD,
  FIE,
  HDC
}

enum Admin {
  Dean,
  HOD
}

service graphql:Service /postgraduateapi on new graphql:Listener(9092) {

service  on httpListener {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/forms"
    }
    resource function applicationStage(http:Caller caller, http:Request req) {
               //
    var ret= testDB ->update("CREATE TABLE student(studentNo INT, name VARCHAR(255), course VARCHAR(255), skills VARCHAR(500), avgGrade VARCHAR(30))");
    //Insert data into the table
    ret = testDB ->update("INSERT INTO student(studentNo, name, course, skills, avgGrade) values (?, ?)", 219081662, "Sherlock Holmes", "Computer Science", "Programming, game development", "distinction");
    //Select data from the table
    table<Student> tableStudent = check testDB ->select("SELECT * FROM student", 
                                                Student, loadToMemory = true);
    //Get the row count
    int count = tableStudent .count();
    //Convert table into json
    json jsonData = check <json>tableStudent;
    //Convert table to xml
    xml xmlData = check <xml>tableStudent;
    //Access each data record    
}
}

service  on httpListener {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/forms/proposal"
    }
    resource function proposalStage(http:Caller caller, http:Request req) {

        foreach s in tableStudent {
        io:println(s);
        
            var ret= studentThesisDB ->update("CREATE TABLE thesis(studentNo INT, thesis VARCHAR(10000000))");
            table<Thesis> studentThesisDB = check studentThesisDB ->select("SELECT * FROM thesis", 
                                                Thesis, loadToMemory = true);
                xml xmlData = check <xml>studentThesisDB;
            xml x2 = xml `<thesis ns0:status="available">
                    <ns0:name>Student Thesis</ns0:name>
                    <author>Sherlock Holmes</author>
                  </thesis>`;
        //Generate and send the response
       http:Response res = new;
       res.setPayload("Account added for: " + name + " with student number:" + studentNo + "\n");
       caller ->respond(res) but {
           error e => log:printError("Error in responding", err = e)
       };

    }    
}
}

service  on httpListener {
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/forms/thesis"
    }
