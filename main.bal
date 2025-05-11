import ballerina/http;
import ballerina/log;

// Define the HTTP service
service /logService on new http:Listener(9090) {

    // Resource function to handle GET requests at the root path
    resource function get .(http:Caller caller, http:Request req) returns error? {
        // Attempt to retrieve the 'X-Debug-Log' header
        string|error debugLogHeader = req.getHeader("X-Debug-Log");

        if debugLogHeader is string {
            // Log the header value if present
            log:printInfo("Received X-Debug-Log header: " + debugLogHeader);
        } else {
            // Log that the header was not found
            log:printInfo("X-Debug-Log header not found in the request.");
        }

        // Create a new response object
        http:Response res = new;

        // Add a custom header to the response
        res.setHeader("X-Processed-By", "logService");

        // Set the response payload
        res.setPayload("Hello! Your request was received.");

        // Send the response back to the client
        check caller->respond(res);
    }
}
