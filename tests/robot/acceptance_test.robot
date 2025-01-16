*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       http://localhost:15550

*** Test Cases ***
Retrieve Election Results
    [Documentation]    Validate that election results can be retrieved correctly.
    Create Session     SafeVoteSession    ${BASE_URL}
    ${response}        GET    /results
    Should Be Equal As Strings    ${response.status_code}    200
    Should Contain    ${response.json()}    {"election": "Community Election 2025"}