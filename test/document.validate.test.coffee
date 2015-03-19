describe 'document.validate', ->
  mabolo = new Mabolo mongodb_uri
  {ObjectID} = Mabolo

  describe 'type and required', ->
    User = mabolo.model 'User',
      username:
        required: true
        type: String

      age:
        required: true
        type: Number

      birthday: Date
      girl: Boolean
      id: ObjectID
      'sub.path': String

    it 'should success with all paths', ->
      jysperm = new User
        username: 'jysperm'
        age: 19
        birthday: new Date '1995-11-25'
        id: ObjectID()
        girl: false
        sub:
          path: 'string'

      return jysperm.validate()

    it 'should success with required paths', ->
      jysperm = new User
        username: 'jysperm'
        age: 19

      return jysperm.validate()

    it 'should fail with invalid value', (done) ->
      jysperm = new User
        username: 'jysperm'
        age: 19
        birthday: 'invalid-date'

      jysperm.validate (err) ->
        err.message.should.match /birthday.*is Date/
        done()

    it 'should fail with missing required path', (done) ->
      jysperm = new User
        username: 'jysperm'

      jysperm.validate (err) ->
        err.message.should.match /age.*is Number/
        done()

  describe 'enum and regex', ->

  describe 'validator', ->