# Test dependencies
cwd         = process.cwd()
path        = require 'path'
chai        = require 'chai'
sinon       = require 'sinon'
sinonChai   = require 'sinon-chai'
expect      = chai.expect
nock        = require 'nock'




# Assertions
chai.use sinonChai
chai.should()




scopes = require path.join(cwd, 'rest', 'scopes')




describe 'REST API Scope Methods', ->

  describe 'list', ->

    describe 'with a missing access token', ->

      {promise,success,failure} = {}

      beforeEach () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .get('/v1/scopes')
          .reply(200, [{_id: 'uuid'}])

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.list.bind(instance)()
          .then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide scopes', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.calledWith sinon.match.instanceOf Error


    describe 'with a successful response', ->

      {promise,success,failure} = {}

      before () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .get('/v1/scopes')
          .reply(200, [{_id: 'uuid'}])

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.list.bind(instance)({ token: 'token' })
          .then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should provide the scopes', ->
        success.should.have.been.calledWith sinon.match [{_id:'uuid'}]

      it 'should not catch an error', ->
        failure.should.not.have.been.called


    describe 'with a failure response', ->

      {promise,success,failure} = {}

      before () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .get('/v1/scopes')
          .reply(404, 'Not found')

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.list.bind(instance)({ token: 'token' })
          .then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide the scopes', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.called


  describe 'get', ->

    describe 'with a missing access token', ->

      {promise,success,failure} = {}

      beforeEach () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .get('/v1/scopes/uuid')
          .reply(200, [{_id: 'uuid'}])

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.get.bind(instance)('uuid')
          .then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide scopes', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.calledWith sinon.match.instanceOf Error


    describe 'with a successful response', ->

      {promise,success,failure} = {}

      before () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          tokens:
            access_token: 'random'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .get('/v1/scopes/uuid')
          .reply(200, {_id: 'uuid'})

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.get.bind(instance)('uuid', { token: 'token' })
          .then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should provide the scope', ->
        success.should.have.been.calledWith sinon.match {_id:'uuid'}

      it 'should not catch an error', ->
        failure.should.not.have.been.called


    describe 'with a failure response', ->

      {promise,success,failure} = {}

      before () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          tokens:
            access_token: 'random'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .get('/v1/scopes/uuid')
          .reply(404, 'Not found')

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.get.bind(instance)('uuid', { token: 'token' })
          .then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide the scope', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.called




  describe 'create', ->

    describe 'with a missing access token', ->

      {promise,success,failure} = {}

      beforeEach () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .post('/v1/scopes')
          .reply(200, [{_id: 'uuid'}])

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.create.bind(instance)({})
          .then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide scope', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.calledWith sinon.match.instanceOf Error


    describe 'with a successful response', ->

      {promise,success,failure} = {}

      before () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          tokens:
            access_token: 'random'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .post('/v1/scopes', {
            redirect_uris: ['https://example.anvil.io']
          })
          .reply(201, {
            _id: 'uuid'
            redirect_uris: ['https://example.anvil.io']
          })

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.create.bind(instance)({
          redirect_uris: ['https://example.anvil.io']
        }, {
          token: 'token'
        }).then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should provide the scope', ->
        success.should.have.been.calledWith sinon.match {_id:'uuid'}

      it 'should not catch an error', ->
        failure.should.not.have.been.called


    describe 'with a failure response', ->

      {promise,success,failure} = {}

      before () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          tokens:
            access_token: 'random'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .post('/v1/scopes', {})
          .reply(400, 'Bad request')

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.create.bind(instance)({
          redirect_uris: ['https://example.anvil.io']
        }, {
          token: 'token'
        }).then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide the scope', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.called




  describe 'update', ->

    describe 'with a missing access token', ->

      {promise,success,failure} = {}

      beforeEach () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .patch('/v1/scopes/uuid')
          .reply(200, {_id: 'uuid'})

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.update.bind(instance)('uuid', {})
          .then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide scope', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.calledWith sinon.match.instanceOf Error



    describe 'with a successful response', ->

      {promise,success,failure} = {}

      before () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          tokens:
            access_token: 'random'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .patch('/v1/scopes/uuid', {
            redirect_uris: ['https://example.anvil.io']
          })
          .reply(200, {
            _id: 'uuid'
            redirect_uris: ['https://example.anvil.io']
          })

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.update.bind(instance)('uuid', {
          redirect_uris: ['https://example.anvil.io']
        }, {
          token: 'token'
        }).then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should provide the scope', ->
        success.should.have.been.calledWith sinon.match({
          redirect_uris: ['https://example.anvil.io']
        })

      it 'should not catch an error', ->
        failure.should.not.have.been.called


    describe 'with a failure response', ->

      {promise,success,failure} = {}

      before () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          tokens:
            access_token: 'random'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .patch('/v1/scopes/uuid', {})
          .reply(400, 'Bad request')

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.update.bind(instance)('uuid', {
          redirect_uris: ['https://example.anvil.io']
        }, {
          token: 'token'
        }).then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide the scope', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.called



  describe 'delete', ->

    describe 'with a missing access token', ->

      {promise,success,failure} = {}

      beforeEach () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .delete('/v1/scopes/uuid')
          .reply(401, 'Unauthorized')

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.delete.bind(instance)('uuid')
          .then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide scope', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.calledWith sinon.match.instanceOf Error



    describe 'with a successful response', ->

      {promise,success,failure} = {}

      before () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          tokens:
            access_token: 'random'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .delete('/v1/scopes/uuid')
          .reply(204)

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.delete.bind(instance)('uuid', { token: 'token' })
          .then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should provide the scope', ->
        success.should.have.been.called

      it 'should not catch an error', ->
        failure.should.not.have.been.called


    describe 'with a failure response', ->

      {promise,success,failure} = {}

      before () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          tokens:
            access_token: 'random'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .delete('/v1/scopes/uuid')
          .reply(404, 'Not found')

        success = sinon.spy()
        failure = sinon.spy()

        promise = scopes.delete.bind(instance)('uuid', { token: 'token' })
          .then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide the scope', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.called


