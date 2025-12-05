User Journey:
User accesses the main Agama page to see some funny facts. It should load and facts displayed to the user.

SLI Type:
Availability

SLI Specification:
Proportion of home page requests are served successfully

SLI Implementations:
Measure the HTTP response code from the logs. If the response code starts with 2, 3, or 4 then it is served successfully. If starts with 5, then not successful.

SLO:
95% of Agama home page requests are served succesfully.


User Journey:
User inserts or deletes a fact from the app. It should update itself within a reasonable amount of time to feel smooth to the user.

SLI Type:
Latency

SLI Specification:
Proportion of valid user HTTP requests are served in <200ms

SLI Implementations:
Measure the latency of the HTTP responses with only code 2. For other HTTP codes the request is invalid.

SLO:
95% of valid Agama home page requests are served in <200ms.