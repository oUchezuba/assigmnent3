//CONSUMER
import ballerina/io;
import ballerina/kafka;
import ballerina/log;
import ballerina/lang;

kafka:ConsumerConfig consumerConfigs{
    bootstrapServers: "localhost:9092"
    groupId: "students",
    topics:["kaff"],
    pollingIntervalMills: 1000,
    keyDeserializerType: kafka:DES_INT,
    valueDeserializerType: kafka:DES_STRING,
    autoCommit: false

};
     Client consumer = new(consumer);

 listener kafka:Consumer consumer = new (consumerConfigs);
service kafkaService on consumer {
    resource function proposalStage(kafka:Consumer kafkaConsumer,
            kafka:ConsumerRecord[] records) {

                string status = "Welcome to Proposal stage!";
    var studentThesisDB = proposalClient->tweet(status);


    if (studentThesisDB is status) {
        test:assertEquals(studentThesisDB.text, status, "Failed.");
        io:println(studentThesisDB);
    } else {
        test:assertFail(<string>studentThesisDB.detail()["message"]);
    }

    }

     
resource function applicationStage(kafka:Consumer kafkaConsumer,
            kafka:ConsumerRecord[] records) {
    string status = "Welcome to Application stage!";
    var applicationResponse = applicationClient->tweet(status);

    if (applicationResponse is status) {
        test:assertEquals(applicationResponse.text, status, "Failed.");
        io:println(applicationResponse);
    } else {
        test:assertFail(<string>applicationResponse.detail()["message"]);
    }
}

resource function thesisStage(kafka:Consumer kafkaConsumer,
            kafka:ConsumerRecord[] records) {
    string status = "Welcome to Thesis stage!";
    var supervisorResponse = thesisClient->tweet(status);

    if (supervisorResponse is status) {
        test:assertEquals(supervisorResponse.text, status, "Failed.");
        io:println(supervisorResponse);
    } else {
        test:assertFail(<string>supervisorResponse.detail()["message"]);
    }
}


resource function graduationStage(kafka:Consumer kafkaConsumer,
            kafka:ConsumerRecord[] records) {
    string status = "Welcome to graduation stage!";
    var validation = examinationClient->tweet(status);

    if (validation is status) {
        test:assertEquals(validation.text, status, "Failed.");
        io:println(validation);
    } else {
        test:assertFail(<string>validation.detail()["message"]);
    }
}

resource function graduationStage(kafka:Consumer kafkaConsumer,
            kafka:ConsumerRecord[] records) {
    string status = "Welcome to graduation stage!";
    var passedExamination = graduationClient->tweet(status);

    if (passedExamination is status) {
        test:assertEquals(passedExamination.text, status, "Failed.");
        io:println(passedExamination);
    } else {
        test:assertFail(<string>passedExamination.detail()["message"]);
    }
}
}
