*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       http://localhost:15550

*** Test Cases ***
Health Check Should Pass
    [Documentation]    Validate that the health check endpoint responds correctly.
    Create Session     SafeVoteSession    ${BASE_URL}
    ${response}        GET    /health
    Should Be Equal As Strings    ${response.status_code}    200
    Should Contain    ${response.json()}    {"status": "ok"}

Submit A Valid Vote
    [Documentation]    Validate that a valid vote can be submitted successfully.
    Create Session     SafeVoteSession    ${BASE_URL}
    ${payload}         Create Dictionary    voterId=12345    candidate=Alice
    ${response}        POST    /vote    json=${payload}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Contain    ${response.json()}    {"message": "Vote submitted successfully"}