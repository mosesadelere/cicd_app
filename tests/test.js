const chai = require('chai');
const chaiHttp = require('chai-http');
const server = require('../server');
const should = chai.should();

chai.use(chaiHttp);

describe('SafeVote API', () => {
    it('should return health status on /health GET', (done) => {
        chai.request(server)
            .get('/health')
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('status').eql('ok');
                done();
            });
    });

    it('should submit a valid vote on /vote POST', (done) => {
        chai.request(server)
            .post('/vote')
            .send({ voterId: '12345', candidate: 'Alice' })
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.have.property('message').eql('Vote submitted successfully');
                done();
            });
    });

    it('should fetch election results on /results GET', (done) => {
        chai.request(server)
            .get('/results')
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('election');
                res.body.should.have.property('candidates');
                done();
            });
    });
});