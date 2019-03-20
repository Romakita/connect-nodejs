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




clientRoles = require path.join(cwd, 'rest', 'clientRoles')




describe 'REST API Client Role Methods', ->

  describe 'listRoles', ->

    describe 'with a successful response', ->

      {promise,success,failure} = {}

      before () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .get('/v1/clients/authority/roles')
          .reply(200, [{name: 'realm'}])

        success = sinon.spy()
        failure = sinon.spy()

        promise = clientRoles.listRoles.bind(instance)('authority', {
          token: 'token'
        }).then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should provide the roles', ->
        success.should.have.been.calledWith sinon.match [{name:'realm'}]

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

        nock(instance.configuration.issuer)
          .get('/v1/clients/authority/roles')
          .reply(404, 'Not found')

        success = sinon.spy()
        failure = sinon.spy()

        promise = clientRoles.listRoles.bind(instance)('authority')
          .then(success, failure)

      after ->
        nock.cleanAll()

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide the roles', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.called




  describe 'add', ->

    describe 'with a successful response', ->

      {promise,success,failure} = {}

      before () ->
        instance =
          configuration:
            issuer: 'https://connect.anvil.io'
          agentOptions: {}

        nock.cleanAll()
        nock(instance.configuration.issuer)
          .put('/v1/clients/authority/roles/realm')
          .reply(201, {
            added: true
          })

        success = sinon.spy()
        failure = sinon.spy()

        promise = clientRoles.addRole.bind(instance)('authority', 'realm', {
          token: 'token'
        }).then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should provide the role', ->
        success.should.have.been.calledWith sinon.match { added: true }

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
          .put('/v1/clients/invalid/roles/addition')
          .reply(400, 'Bad request')

        success = sinon.spy()
        failure = sinon.spy()

        promise = clientRoles.addRole.bind(instance)('invalid', 'addition', {
          token: 'token'
        }).then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide the role', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.called




  describe 'delete', ->

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
          .delete('/v1/clients/authority/roles/realm')
          .reply(204)

        success = sinon.spy()
        failure = sinon.spy()

        promise = clientRoles.deleteRole.bind(instance)('authority', 'realm', {
          token: 'token'
        }).then(success, failure)

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should provide the role', ->
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
          .delete('/v1/clients/invalid/roles/deletion')
          .reply(404, 'Not found')

        success = sinon.spy()
        failure = sinon.spy()

        promise = clientRoles.deleteRole.bind(instance)('invalid', 'deletion', {
          token: 'token'
        }).then(success, failure)

      after ->
        nock.cleanAll()

      it 'should return a promise', ->
        promise.should.be.instanceof Promise

      it 'should not provide the role', ->
        success.should.not.have.been.called

      it 'should catch an error', ->
        failure.should.have.been.called


