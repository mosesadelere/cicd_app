const express = require('express');
const app = express();
const port = 15550;

// Middleware to parse JSON requests
app.use(express.json());

// Example routes
app.get('/health', (req, res) => {
    res.status(200).send({ status: 'ok', message: 'SafeVote backend is operational!' });
});

app.post('/vote', (req, res) => {
    const { voterId, candidate } = req.body;
    if (!voterId || !candidate) {
        return res.status(400).send({ message: 'Invalid vote submission' });
    }

    // Placeholder logic for processing a vote
    console.log(`Vote received from Voter ID: ${voterId} for Candidate: ${candidate}`);

    res.status(200).send({ message: 'Vote submitted successfully' });
});

app.get('/results', (req, res) => {
    // Placeholder for retrieving election results
    const results = {
        election: 'Community Election 2025',
        candidates: [
            { name: 'Alice', votes: 120 },
            { name: 'Bob', votes: 98 },
        ],
    };
    res.status(200).send(results);
});

// Start server
app.listen(port, () => {
    console.log(`SafeVote backend running on http://localhost:${port}`);
});

// Export app for testing purposes
module.exports = app;